import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:track_my_car/models/list_item.dart';

class DatabaseAccess {
  Database _db;
  bool didInit = false;
  static final DatabaseAccess _databaseAccess = DatabaseAccess._internal();

  DatabaseAccess._internal();

  static DatabaseAccess get() {
    return _databaseAccess;
  }

  Future<Database> getDb() async {
    if (!didInit) {
      await _init();
    }
    return _db;
  }

  Future init() async {
    return await _init();
  }

  Future _init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "track_my_car_3.db");
    _db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
          create table vehicles (
            id integer primary key autoincrement,
            name text not null,
            number text not null,
            password text not null,
            lastLongitude text,
            lastLatitude text,
            profileId integer
          );
          create table profiles (
            id integer primary key autoincrement,
            name text not null,
            position text not null,
            cut text,
            resume text,
            status text,
            reset text,
            overSpeed text,
            setCenterNumber text,
            deleteCenterNumber text,
          );
        ''');
    });
    didInit = true;
  }

  Future<Map<String, dynamic>> insert(String tableName, Map<String, dynamic> entity) async {
    var db = await _databaseAccess.getDb();
    entity['id'] = await db.insert(tableName, entity);
    return entity;
  }

  Future<Map<String, dynamic>> update(String tableName, Map<String, dynamic> entity) async {
    var db = await _databaseAccess.getDb();
    entity['id'] = await db.update(tableName, entity, where: 'id = ${entity['id']}');
    return entity;
  }

  Future delete(String tableName, int id) async {
    await _db.delete(tableName, where: "id = ?", whereArgs: [id]);
  }

  Future<List<ListItem>> listAll(String tableName, List<String> keys) async {
    var db = await getDb();
    List<Map> queryResult =
        await db.query(tableName, columns: keys);
    var values = queryResult
        .map((valueMap) => ListItem.fromMap({
              0: valueMap[keys[0]],
              1: valueMap[keys[1]],
              2: valueMap[keys[2]],
            }))
        .toList();
    return values;
  }

  Future<Map<String, dynamic>> getById(String tableName, int id, List<String> columns) async {
    var db = await getDb();
    List<Map> queryResult = await db.query(tableName,
        columns: columns,
        where: "id =?",
        whereArgs: [id]);
    if (queryResult.length > 0) {
      return queryResult.first;
    }
    return null;
  }

  Future close() async => await _db.close();

}