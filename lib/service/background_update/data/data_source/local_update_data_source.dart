import 'package:password/core/utiles/typedef.dart';
import 'package:password/service/background_update/data/model/update_data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

abstract class LocalUpdateDataSource {
  const LocalUpdateDataSource();

  Future<bool> upDateTable(List<DataMap> map);

  Future<List<UpdateDataModel>> getAccountList();

  String getToken();

  Future<int> getLastUpdate();
}

class LocalUpdateDataSourceImplementation extends LocalUpdateDataSource {
  const LocalUpdateDataSourceImplementation({
    required SharedPreferences sharedPreferences,
    required Database dataBase,
  })  : _preferences = sharedPreferences,
        _db = dataBase;

  final SharedPreferences _preferences;
  final Database _db;

  @override
  Future<List<UpdateDataModel>> getAccountList() async {
    List<DataMap> result = await _db.query(
      "account_table",
      where: "is_update = ?",
      whereArgs: [0],
    );
    final map = List.generate(result.length, (index) => UpdateDataModel.fromMap(result[index]));
    return map;
  }

  @override
  Future<int> getLastUpdate() async {
    final result = _preferences.getInt("last_update") ?? 0;
    return result;
  }

  @override
  String getToken() {
    final result = _preferences.getString('token') ?? " ";
    return result;
  }

  @override
  Future<bool> upDateTable(List<DataMap> map) async {
    for (var element in map) {
      await _db.insert("account_table",element,conflictAlgorithm: ConflictAlgorithm.replace);
    }
    return true;
  }
}
