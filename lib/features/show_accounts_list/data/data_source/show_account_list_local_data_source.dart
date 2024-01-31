import 'package:password/core/utiles/data_base_helper.dart';
import 'package:password/core/utiles/typedef.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

abstract class ShowAccountsListLocalDataSource {
  const ShowAccountsListLocalDataSource();

  Stream<List<DataMap>> getAccountList();

  String getToken();

  dynamic saveData(DataMap data);

  Future<bool> lastUpdate(int date);

  int getLastUpdate();
}

class ShowAccountsListLocalDataSourceImplementation extends ShowAccountsListLocalDataSource {
  const ShowAccountsListLocalDataSourceImplementation({
    required SharedPreferences sharedPreferences,
    required DataBaseHelper dataBase,
  })  : _preferences = sharedPreferences,
        _db = dataBase;

  final SharedPreferences _preferences;
  final DataBaseHelper _db;

  @override
  Stream<List<DataMap>> getAccountList(){
    String tableName = getToken();
    if(tableName.isEmpty) throw Exception();
    final result = _db.streamDB(tableName);
    return result;
  }

  @override
  saveData(DataMap data) async {
    String tableName = getToken();
    if(tableName.isEmpty) throw Exception();
    final result = await _db.insert(data, tableName);
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
