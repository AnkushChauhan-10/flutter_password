import 'package:password/core/utiles/data_base_helper.dart';
import 'package:password/screen/save_data/data/model/account_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

abstract class EditDataOfflineRepo {
  const EditDataOfflineRepo();

  dynamic editData(AccountModel data, String table);

  String getToken();

}

class EditDataOfflineRepoImplementation extends EditDataOfflineRepo {
  const EditDataOfflineRepoImplementation({
    required DataBaseHelper dataBase,
    required SharedPreferences sharedPreferences,
  })  : _db = dataBase,
        _sharedPreferences = sharedPreferences;

  final DataBaseHelper _db;
  final SharedPreferences _sharedPreferences;

  @override
  editData(AccountModel data, String table) async {
    final result = await _db.insert(
      data.toMap(),
      table,
    );
    return result;
  }

  @override
  String getToken() {
    return _sharedPreferences.getString("token") ?? "";
  }
}
