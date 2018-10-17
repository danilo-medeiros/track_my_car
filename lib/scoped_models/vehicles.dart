import 'package:scoped_model/scoped_model.dart';
import 'package:track_my_car/database/vehicle_database.dart';
import 'package:track_my_car/models/vehicle.dart';

class VehicleModel extends Model {

  /// Selected vehicle to show/edit
  Vehicle selectedVehicle;

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

  Future updateList() async {
    vehicles = await _database.listAll();
  }

  Future _saveVehicle(Vehicle vehicle) async {
    selectedVehicle = await _database.insert(vehicle);
  }

  Future _updateVehicle(Vehicle vehicle) async {
    selectedVehicle = await _database.update(vehicle);
  }

  void list() {
    _loading = true;
    updateList().then((_) {
      print("Finished loading");
      _loading = false;
      print("Notifying listeners!!!!");
      notifyListeners();
    });
  }

  void save(Vehicle vehicle) {
    _loading= true;
    _saveVehicle(vehicle).then((_) {
      notifyListeners();
    }).then((_) {
      list();
    });
  }

  void update(Vehicle vehicle) {
    _loading= true;
    _updateVehicle(vehicle).then((_) {
      notifyListeners();
    }).then((_) {
      list();
    });
  }

  void delete() {
    _loading = true;
    _database.delete(selectedVehicle.id)
      .then((id) => notifyListeners())
      .then((_) => list());
  }

  VehicleModel() {
    print("========= VehicleModel Constructor =========");
    print("========= Fetching vehicle data =========");
    list();
  }

}
