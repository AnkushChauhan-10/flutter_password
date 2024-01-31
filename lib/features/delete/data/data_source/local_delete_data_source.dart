import 'package:password/core/utiles/data_base_helper.dart';
import 'package:password/core/utiles/typedef.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDeleteDataSource {
  const LocalDeleteDataSource();

  Future<bool> deleteData(DataMap dataMap);

  String getToken();
}

class LocalDeleteDataSourceImplementation extends LocalDeleteDataSource {
  const LocalDeleteDataSourceImplementation({required SharedPreferences sharedPreferences, required DataBaseHelper database})
      : _sharedPreferences = sharedPreferences,
        _database = database;

  final SharedPreferences _sharedPreferences;
  final DataBaseHelper _database;

  @override
  Future<bool> deleteData(DataMap dataMap) async {
    final table = getToken();
    final result = await _database.delete(dataMap, table);
    return result;
  }

  @override
  String getToken() {
    final result = _sharedPreferences.getString('token') ?? " ";
    return result;
  }
}
