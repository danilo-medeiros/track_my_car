import 'package:sqflite/sqflite.dart';
import 'package:track_my_car/database/database.dart';
import 'package:track_my_car/models/list_item.dart';
import 'package:track_my_car/models/vehicle.dart';

class VehicleDatabase {
  final String tableName = "vehicles";
  static final VehicleDatabase _vehicleDatabase = VehicleDatabase._internal();
  
  DatabaseAccess _databaseAccess = DatabaseAccess.get();

  VehicleDatabase._internal();

  static VehicleDatabase get() {
    return _vehicleDatabase;
  }

  Future<Database> _getDb() async {
    return await this._databaseAccess.getDb();
  }

  Future<List<Vehicle>> getByName(String name) async {
    var db = await _getDb();
    List<Map> queryResult = await db.query(tableName,
        columns: ["id", "name", "password"], where: "name like %$name%");
    var vehicles =
        queryResult.map((vehicleMap) => Vehicle.fromMap(vehicleMap)).toList();
    return vehicles;
  }

  Future<Vehicle> getById(int id) async {
    Map<String, dynamic> result = await _databaseAccess.getById(tableName, id, [
          "id",
          "name",
          "number",
          "password",
          "lastLatitude",
          "lastLongitude",
          "profileId"
        ]);
    return Vehicle.fromMap(result);
  }

  Future<Vehicle> insert(Vehicle vehicle) async {
    Map<String, dynamic> result =  await _databaseAccess.insert(tableName, vehicle.toMap());
    return Vehicle.fromMap(result);
  }

  Future<Vehicle> update(Vehicle vehicle) async {
    Map<String, dynamic> result =  await _databaseAccess.update(tableName, vehicle.toMap());
    return Vehicle.fromMap(result);
  }

  Future delete(int id) async {
    await _databaseAccess.delete(tableName, id);
  }

  Future<List<ListItem>> listAll() async {
    return await _databaseAccess.listAll(tableName, ['id', 'name', 'number']);
  }

}
