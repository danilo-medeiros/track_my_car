import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:sqflite/sqflite.dart';
import 'package:track_my_car/models/list_item.dart';
import 'package:track_my_car/models/vehicle.dart';

class VehicleDatabase {
  final String tableName = "vehicles";
  static final VehicleDatabase _vehicleDatabase = VehicleDatabase._internal();
  bool didInit = false;
  Database db;

  VehicleDatabase._internal();

  static VehicleDatabase get() {
    return _vehicleDatabase;
  }

  Future<Database> _getDb() async {
    if (!didInit) {
      await _init();
    }
    return db;
  }

  Future init() async {
    return await _init();
  }

  Future _init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "track_my_car_2.db");
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
          create table $tableName (
            id integer primary key autoincrement,
            name text not null,
            number text not null,
            password text not null,
            lastLongitude text,
            lastLatitude text,
            profileId integer
          )
        ''');
      print("============= CREATING $tableName TABLE =============");
    });
    didInit = true;
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
    var db = await _getDb();
    List<Map> queryResult = await db.query(tableName,
        columns: [
          "id",
          "name",
          "number",
          "password",
          "lastLatitude",
          "lastLongitude",
          "profileId"
        ],
        where: "id =?",
        whereArgs: [id]);
    if (queryResult.length > 0) {
      return new Vehicle.fromMap(queryResult.first);
    }
    return null;
  }

  Future<Vehicle> insert(Vehicle vehicle) async {
    var db = await _getDb();
    vehicle.id = await db.insert(tableName, vehicle.toMap());
    return vehicle;
  }

  Future<List<ListItem>> listAll() async {
    var db = await _getDb();
    List<Map> queryResult =
        await db.query(tableName, columns: ["id", "name", "number"]);
    var vehicles = queryResult
        .map((vehicleMap) => ListItem.fromMap({
              0: vehicleMap["id"],
              1: vehicleMap["name"],
              2: vehicleMap["number"]
            }))
        .toList();
    return vehicles;
  }

  Future delete(int id) async {
    await db.delete(tableName, where: "id = ?", whereArgs: [id]);
  }

  Future update(Vehicle vehicle) async {
    print(vehicle.id);
    final Future<int> future = db.update(tableName, vehicle.toUpdatableMap(),
        where: "id = ${vehicle.id}");
    return future.then((int t) => print(t));
  }

  Future close() async => await db.close();
}
