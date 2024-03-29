import 'package:password/core/utiles/data_base_helper.dart';
import 'package:password/screen/save_data/data/model/account_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

abstract class SaveDataOfflineRepo {
  const SaveDataOfflineRepo();

  dynamic saveData(AccountModel data);

  String getToken();

  lastUpdate(num date);
}

class SaveDataOfflineRepoImplementation extends SaveDataOfflineRepo {
  const SaveDataOfflineRepoImplementation({
    required DataBaseHelper dataBase,
    required SharedPreferences sharedPreferences,
  })  : _db = dataBase,
        _sharedPreferences = sharedPreferences;

  final DataBaseHelper _db;
  final SharedPreferences _sharedPreferences;

  @override
  saveData(AccountModel data) async {
    String tableName = getToken();
    if (tableName.isEmpty) return;
    final result = await _db.insert(
      data.toMap(),
      tableName,
    );
    return result;
  }

  @override
  String getToken() {
    return _sharedPreferences.getString("token") ?? "";
  }

  @override
  lastUpdate(num date) async {
    print(date);
    await _sharedPreferences.setInt("last_update", date.toInt());
  }
}
