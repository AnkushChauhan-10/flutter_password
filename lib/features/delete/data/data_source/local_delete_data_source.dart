import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

abstract class LocalDeleteDataSource {
  const LocalDeleteDataSource();

  Future<bool> deleteData(String name);

  String getToken();
}

class LocalDeleteDataSourceImplementation extends LocalDeleteDataSource {
  const LocalDeleteDataSourceImplementation({required SharedPreferences sharedPreferences, required Database database})
      : _sharedPreferences = sharedPreferences,
        _database = database;

  final SharedPreferences _sharedPreferences;
  final Database _database;

  @override
  Future<bool> deleteData(String name) async {
    final result = await _database.delete(
      'account_table',
      where: "site_name = ?",
      whereArgs: [name],
    );
    return result == 0 ? false : true;
  }

  @override
  String getToken(){
    final result = _sharedPreferences.getString('token') ?? " ";
    return result;
  }
}
