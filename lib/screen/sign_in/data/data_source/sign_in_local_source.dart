import 'package:password/core/utiles/data_base_helper.dart';
import 'package:password/core/utiles/typedef.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SignInLocalSource {
  const SignInLocalSource();

  saveToken(String token);

  Future<bool> saveUserDetails(DataMap user);
}

class SignInLocalSourceImplementation extends SignInLocalSource {
  const SignInLocalSourceImplementation({required SharedPreferences sharedPreferences, required DataBaseHelper db})
      : _sharedPreferences = sharedPreferences,
        _db = db;

  final SharedPreferences _sharedPreferences;
  final DataBaseHelper _db;

  @override
  saveToken(String token) async {
    return await _sharedPreferences.setString("token", token);
  }

  @override
  Future<bool> saveUserDetails(DataMap user) async {
    final insert = await _db.insert(user, "users_table");
    final create = await _db.createTable(user['token']);
    return insert && create;
  }
}
