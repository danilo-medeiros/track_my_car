import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:sqflite/sqflite.dart';
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
    String path = join(documentsDirectory.path, "track_my_car.db");
    db = await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          create table $tableName (
            id integer primary key autoincrement,
            name text not null,
            number text not null,
            password text not null,
            profileId integer
          )
        ''');
      });
    didInit = true;
  }

  Future<Vehicle> getById(int id) async {
    var db = await _getDb();
    List<Map> queryResult = await db.query(tableName,
      columns: [ "name", "number", "password", "profileId" ],
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

  Future<List<Vehicle>> listAll() async {
    var db = await _getDb();
    List<Map> queryResult = await db.query(tableName,
      columns: [ "id", "name", "number", "password", "profileId" ]);
    var vehicles = queryResult.map((vehicleMap) => 
      Vehicle.fromMap(vehicleMap)).toList();
    return vehicles;
  }

  Future delete(int id) async {
    await db.delete(tableName, where: "id = ?", whereArgs: [id]);
  }

  Future<Vehicle> update(Vehicle vehicle) async {
    vehicle.id = await db.update(tableName, vehicle.toMap(), 
      where: "id = ${vehicle.id}",
      whereArgs: [vehicle.id]);
    return vehicle;
  }

  Future close() async => await db.close();
}