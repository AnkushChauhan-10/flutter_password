
import 'package:password/screen/save_data/data/model/account_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

abstract class EditDataOfflineRepo {
  const EditDataOfflineRepo();

  dynamic editData(AccountModel data);

  String getToken();
  lastUpdate(num date);
}

class EditDataOfflineRepoImplementation extends EditDataOfflineRepo {
  const EditDataOfflineRepoImplementation({
    required Database dataBase,
    required SharedPreferences sharedPreferences,
  })  : _db = dataBase,
        _sharedPreferences = sharedPreferences;

  final Database _db;
  final SharedPreferences _sharedPreferences;

  @override
  editData(AccountModel data) async {
    final result = await _db.insert(
      "account_table",
      data.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return result;
  }

  @override
  String getToken() {
    return _sharedPreferences.getString("token") ?? "";
  }

  @override
  lastUpdate(num date) async{
    print(date);
    await _sharedPreferences.setInt("last_update", date.toInt());
  }
}
