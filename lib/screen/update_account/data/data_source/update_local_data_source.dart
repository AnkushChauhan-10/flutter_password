import 'package:password/core/utiles/typedef.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

abstract class UpdateLocalDataSource {
  const UpdateLocalDataSource();

  Future<bool> update(DataMap map);

  String getToken();
}

class UpdateLocalDataSourceImplementation extends UpdateLocalDataSource {
  const UpdateLocalDataSourceImplementation({required Database database, required SharedPreferences sharedPreferences})
      : _database = database,
        _sharedPreferences = sharedPreferences;

  final Database _database;
  final SharedPreferences _sharedPreferences;

  @override
  Future<bool> update(DataMap map) async {
    await _database.update("account_table", map, where: "title = ?", whereArgs: [map['title']]);
    return true;
  }

  @override
  String getToken(){
    final result = _sharedPreferences.getString('token') ?? " ";
    return result;
  }
}
