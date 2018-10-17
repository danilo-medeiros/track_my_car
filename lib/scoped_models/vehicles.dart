import 'package:scoped_model/scoped_model.dart';
import 'package:track_my_car/database/vehicle_database.dart';
import 'package:track_my_car/models/vehicle.dart';

/// Vehicle Scoped Model that holds the vehicle's list and selected vehicle state
class VehicleModel extends Model {
  /// Selected vehicle to show/edit
  Vehicle _selectedVehicle;

  /// Attribute to set the state of loading
  bool _loading = false;

  /// Database access class
  VehicleDatabase _database = VehicleDatabase.get();

  /// Vehicles list
  List<Vehicle> vehicles = [];

  // CHECK IF SCREEN IS LOADING
  bool get isLoading {
    return _loading;
  }

  VehicleModel() {
    list();
  }

  Vehicle get selectedVehicle {
    if (_selectedVehicle == null) {
      return new Vehicle();
    }
    return _selectedVehicle;
  }

  set selectedVehicle(Vehicle selectedVehicle) {
    _selectedVehicle = selectedVehicle;
  }

  void list() {
    _loading = true;
    _database.listAll().then((_vehicles) {
      vehicles = _vehicles;
      notifyListeners();
    }).then((_) => _loading = false);
  }

  /// Save vehicle and list vehicles
  void save(Vehicle vehicle) {
    _loading = true;
    _database.insert(vehicle).then((vehicle) {
      selectedVehicle = vehicle;
      notifyListeners();
    }).then((_) => list());
  }

  /// Update vehicle and list vehicles
  void update(Vehicle vehicle) {
    _loading = true;
    _database.update(vehicle).then((vehicle) {
      selectedVehicle = vehicle;
      notifyListeners();
    }).then((_) {
      list();
    });
  }

  /// Delete vehicle and list vehicles
  void delete() {
    _loading = true;
    _database.delete(selectedVehicle.id).then((id) {
      selectedVehicle = null;
      notifyListeners();
    }).then((_) => list());
  }

  void select(num id) {
    _loading = true;
    _database.getById(id).then((vehicle) {
      selectedVehicle = vehicle;
      notifyListeners();
    }).then((_) => _loading = false);
  }

}
