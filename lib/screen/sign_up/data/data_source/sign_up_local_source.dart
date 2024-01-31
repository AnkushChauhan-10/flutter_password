import 'package:password/core/model/users.dart';
import 'package:password/core/utiles/data_base_helper.dart';
import 'package:password/screen/sign_up/data/models/SingUpDetailsModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

abstract class SignUpLocalSource {
  const SignUpLocalSource();

  saveToken(String token);

  saveUserDetails(SignUpDetailsModel signUpDetailsModel, String token);
}

class SignUpLocalSourceImplementation extends SignUpLocalSource {
  const SignUpLocalSourceImplementation({required DataBaseHelper db, required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences,
        _db = db;

  final SharedPreferences _sharedPreferences;
  final DataBaseHelper _db;

  @override
  saveToken(String token) async {
    return await _sharedPreferences.setString("token", token);
  }

  @override
  saveUserDetails(SignUpDetailsModel signUpDetailsModel, String token) async {
    UsersModel user = UsersModel(
      email: signUpDetailsModel.email,
      name: signUpDetailsModel.name,
      token: token,
    );
    final insert = await _db.insert(user.toMap(), "users_table");
    final create = await _db.createTable(user.token);
    return insert && create;
    // final r = await _sharedPreferences.setStringList("user_data", user.toListString());
    // print(_sharedPreferences.getStringList("user_data"));
    // print("-=============----------=====================================================================================");
  }
}
