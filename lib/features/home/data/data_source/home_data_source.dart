import 'package:password/core/model/users.dart';
import 'package:password/core/utiles/typedef.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

abstract class HomeDataSource {
  const HomeDataSource();

  Future<List<DataMap>> getAccountList();

  String getToken();

  UsersModel getUserData();

  Future<bool> signOut();

  Future<bool> deleteAccount(String siteName);
}

class HomeDataSourceImplementation extends HomeDataSource {
  const HomeDataSourceImplementation({
    required SharedPreferences sharedPreferences,
    required Database dataBase,
  })  : _preferences = sharedPreferences,
        _db = dataBase;

  final SharedPreferences _preferences;
  final Database _db;

  @override
  Future<List<DataMap>> getAccountList() async {
    List<DataMap> result = await _db.query("account_table");
    return result;
  }

  @override
  String getToken() {
    final result = _preferences.getString('token') ?? " ";
    return result;
  }

  @override
  UsersModel getUserData() {
    List<String>? result = _preferences.getStringList("user_data");
    return UsersModel.fromListString(result!);
  }

  @override
  Future<bool> signOut() async {
    await _preferences.remove("user_data");
    final result = await _preferences.remove("token");
    return result;
  }

  @override
  Future<bool> deleteAccount(String siteName) async {
    final result = await _db.delete(
      'account_table',
      where: "site_name = ?",
      whereArgs: [siteName],
    );
    return result == 0 ? false : true;
  }
}
