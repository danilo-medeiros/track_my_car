import 'package:sqflite/sqflite.dart';

class VehicleProvider {

  

  VehicleProvider() {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, "track_my_car.db"); 
  }

}