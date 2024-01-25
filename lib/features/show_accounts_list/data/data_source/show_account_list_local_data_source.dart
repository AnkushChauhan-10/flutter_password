import 'package:password/core/utiles/typedef.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

abstract class ShowAccountsListLocalDataSource {
  const ShowAccountsListLocalDataSource();

  Future<List<DataMap>> getAccountList();

  String getToken();

  dynamic saveData(DataMap data);

  Future<bool> lastUpdate(int date);

  int getLastUpdate();
}

class ShowAccountsListLocalDataSourceImplementation extends ShowAccountsListLocalDataSource {
  const ShowAccountsListLocalDataSourceImplementation({
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
  saveData(DataMap data) async {
    final result = await _db.insert(
      "account_table",
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return result;
  }

  @override
  Future<bool> lastUpdate(int date) async {
    await _preferences.setInt("last_update", date);
    return true;
  }

  @override
  String getToken() {
    return _preferences.getString("token") ?? "";
  }

  @override
  int getLastUpdate() {
    int result = _preferences.getInt("last_update") ?? 0;
    return result;
  }
}
