import 'package:password/core/utiles/typedef.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

abstract class ShowAccountsListLocalDataSource {
  const ShowAccountsListLocalDataSource();

  Future<List<DataMap>> getAccountList();

  String getToken();
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
  String getToken() {
    final result = _preferences.getString('token') ?? " ";
    return result;
  }
}
