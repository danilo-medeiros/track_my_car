import 'package:scoped_model/scoped_model.dart';
import 'package:track_my_car/database/vehicle_database.dart';
import 'package:track_my_car/models/vehicle.dart';

class VehicleModel extends Model {

  bool _loading = false;
  VehicleDatabase _vehicleDatabase = VehicleDatabase.get();
  List<Vehicle> _vehicles = [
    /* Vehicle.fromVehicle("CHEVROLET CAMARO", "(84) 99212-0696", "123125", 2),
    Vehicle.fromVehicle("FORD MUSTANG", "(84) 99417-5639", "123125", 2),
    Vehicle.fromVehicle("TOYOTA COROLLA", "(84) 99886-4452", "123125", 2),
    Vehicle.fromVehicle("FIAT 500", "(84) 99855-4452", "123125", 2) */
  ];

  bool get isLoading {
    return _loading;
  } 

  VehicleModel() {
    _loading = true;
    _vehicleDatabase.listAll().then(
      (vehicles) {
        _vehicles = vehicles;
        notifyListeners();
      }
    ).then((_) {
      _loading = false;
    }); 
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

  void deleteVehicle(num id) {
    _vehicles.removeWhere((vehicle) => vehicle.id == id);
  }

  Vehicle getVehicle(num id) {
    return _vehicles.firstWhere((vehicle) => vehicle.id == id);
  }

}