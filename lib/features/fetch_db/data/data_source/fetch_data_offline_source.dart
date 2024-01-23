import 'package:password/core/utiles/typedef.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

abstract class FetchDataOfflineRepo {
  const FetchDataOfflineRepo();

  dynamic saveData(DataMap data);

  Future<bool> lastUpdate(int date);

  int getLastUpdate();

  String getToken();
}

class FetchDataOfflineRepoImplementation extends FetchDataOfflineRepo {
  const FetchDataOfflineRepoImplementation({
    required Database dataBase,
    required SharedPreferences sharedPreferences,
  })  : _db = dataBase,
        _sharedPreferences = sharedPreferences;

  final Database _db;
  final SharedPreferences _sharedPreferences;

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
    await _sharedPreferences.setInt("last_update", date);
    return true;
  }

  @override
  String getToken() {
    return _sharedPreferences.getString("token") ?? "";
  }

  @override
  int getLastUpdate() {
    int result = _sharedPreferences.getInt("last_update") ?? 0;
    return result;
  }
}
