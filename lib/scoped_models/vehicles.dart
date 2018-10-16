import 'package:scoped_model/scoped_model.dart';
import 'package:track_my_car/database/vehicle_database.dart';
import 'package:track_my_car/models/vehicle.dart';

class VehicleModel extends Model {
  Vehicle selectedVehicle;
  bool _loading = false;
  VehicleDatabase _vehicleDatabase = VehicleDatabase.get();
  List<Vehicle> _vehicles = [];

  bool get isLoading {
    return _loading;
  }

  VehicleModel() {
    _loading = true;
    _listVehicles().then((_) {
      _loading = false;
      notifyListeners();
    });
  }

  Future _listVehicles() async {
    _vehicles = await _vehicleDatabase.listAll();
  }

  List<Vehicle> get vehicles {
    return List.from(_vehicles);
  }

  Vehicle addVehicle(Vehicle vehicle) {
    _vehicles.add(vehicle);
    return vehicle;
  }

  Vehicle updateVehicle(Vehicle vehicle) {
    return vehicle;
  }

  void deleteVehicle() {
    _loading = true;
    print("Deleting");
    _vehicleDatabase
        .delete(selectedVehicle.id)
        .then((_) => _listVehicles())
        .then((_) {
      _loading = false;
      notifyListeners();
    });
  }

  Vehicle getVehicle(num id) {
    return _vehicles.firstWhere((vehicle) => vehicle.id == id);
  }
}
