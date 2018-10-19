import 'package:scoped_model/scoped_model.dart';
import 'package:track_my_car/database/vehicle_database.dart';
import 'package:track_my_car/models/list_item.dart';
import 'package:track_my_car/models/vehicle.dart';

/// Vehicle Scoped Model that holds the vehicle's list and selected vehicle state
class VehicleModel extends Model {
  /// Selected vehicle to show/edit
  Vehicle selectedVehicle;

  /// Database access class
  final VehicleDatabase _database = VehicleDatabase.get();

  Future<List<ListItem>> list() async {
    return await _database.listAll();
  }

  void select(Map<int, dynamic> vehicleMap) {
    selectedVehicle = Vehicle(id: vehicleMap[0], name: vehicleMap[1], number: vehicleMap[2]);
  }

  Future fetch() async {
    return await _database.getById(selectedVehicle.id).then((vehicle) => selectedVehicle = vehicle);
  }

  /// Save vehicle and list vehicles
  Future save(Vehicle vehicle) async {
    selectedVehicle = await _database.insert(vehicle);
  }

  /// Update vehicle and list vehicles
  Future<void> update(Vehicle vehicle) async {
    vehicle.id = selectedVehicle.id;
    return _database.update(vehicle).then((_) {
      notifyListeners();
    });
  }

  Future delete() async {
    return await _database.delete(selectedVehicle.id).then((_) => selectedVehicle = null);
  }
  
}
