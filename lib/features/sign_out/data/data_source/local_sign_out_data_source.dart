import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalSignOutDataSource {
  const LocalSignOutDataSource();

  Future<bool> signOutLocal();
}

class LocalSignOutDataSourceImplementation extends LocalSignOutDataSource {
  const LocalSignOutDataSourceImplementation({required SharedPreferences sharedPreferences}) :_sharedPreferences =sharedPreferences;

  final SharedPreferences _sharedPreferences;

  @override
  Future<bool> signOutLocal() async {
    await _sharedPreferences.remove("user_data");
    final result = await _sharedPreferences.remove("token");
    return result;
  }

}