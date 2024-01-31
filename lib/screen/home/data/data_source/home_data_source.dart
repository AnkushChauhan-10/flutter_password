import 'package:password/core/utiles/data_base_helper.dart';
import 'package:password/core/utiles/typedef.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

abstract class HomeDataSource {
  const HomeDataSource();

  String getToken();

  Future<bool> setToken(String token);

  Future<List<DataMap>> getUsers();
}

class HomeDataSourceImplementation extends HomeDataSource {
  const HomeDataSourceImplementation({
    required SharedPreferences sharedPreferences,
    required DataBaseHelper dataBase,
  })  : _preferences = sharedPreferences,
        _db = dataBase;

  final SharedPreferences _preferences;
  final DataBaseHelper _db;

  @override
  String getToken() {
    final result = _preferences.getString('token') ?? " ";
    return result;
  }

  @override
  Future<List<DataMap>> getUsers() async {
    List<DataMap> result = await _db.get("users_table");
    return result;
  }

  @override
  Future<bool> setToken(String token) async {
    bool r = await _preferences.setString('token', token);
    return r;
  }
}
