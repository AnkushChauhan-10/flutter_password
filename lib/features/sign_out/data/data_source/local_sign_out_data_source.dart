import 'package:password/core/utiles/data_base_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalSignOutDataSource {
  const LocalSignOutDataSource();

  Future<bool> signOutLocal();
}

class LocalSignOutDataSourceImplementation extends LocalSignOutDataSource {
  const LocalSignOutDataSourceImplementation({
    required SharedPreferences sharedPreferences,
    required DataBaseHelper dataBaseHelper,
  })  : _sharedPreferences = sharedPreferences,
        _dataBaseHelper = dataBaseHelper;

  final SharedPreferences _sharedPreferences;
  final DataBaseHelper _dataBaseHelper;

  @override
  Future<bool> signOutLocal() async {
    String token = _sharedPreferences.getString("token") ?? "";
    if (token.isEmpty) return false;
    final db = await _dataBaseHelper.delete(value: {'token': token}, table: 'users_table', where: 'token');
    final table = await _dataBaseHelper.deleteTable(token);
    final result = await _sharedPreferences.remove("token");
    return result && db && table;
  }
}
