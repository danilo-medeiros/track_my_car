import 'package:track_my_car/database/database.dart';
import 'package:track_my_car/models/list_item.dart';
import 'package:track_my_car/models/profile.dart';

class ProfileDatabase {
  final String tableName = 'profiles';
  static final ProfileDatabase _profileDatabase = ProfileDatabase.internal();

  DatabaseAccess _databaseAccess = DatabaseAccess.get();

  ProfileDatabase.internal();

  static ProfileDatabase get() {
    return _profileDatabase;
  }

  Future<Profile> insert(Profile profile) async {
    Map<String, dynamic> result =
        await _databaseAccess.insert(tableName, profile.toMap());
    return Profile.fromMap(result);
  }

  Future<Profile> update(Profile profile) async {
    Map<String, dynamic> result =
        await _databaseAccess.update(tableName, profile.toMap());
    return Profile.fromMap(result);
  }

  Future delete(int id) async {
    return _databaseAccess.delete(tableName, id);
  }

  Future<Profile> getById(int id) async {
    Map<String, dynamic> result = await _databaseAccess.getById(tableName, id, [
      'id',
      'name',
      'position',
      'cut',
      'resume',
      'status',
      'reset',
      'overSpeed',
      'centerNumber',
      'deleteCenterNumber'
    ]);
    return Profile.fromMap(result);
  }

  Future<List<ListItem>> listAll() async {
    return await _databaseAccess.listAll(tableName, ['id', 'name', 'position']);
  }

}
