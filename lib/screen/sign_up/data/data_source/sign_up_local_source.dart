import 'package:password/core/model/users.dart';
import 'package:password/screen/sign_up/data/models/SingUpDetailsModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SignUpLocalSource {
  const SignUpLocalSource();

  saveToken(String token);

  saveUserDetails(SignUpDetailsModel signUpDetailsModel);
}

class SignUpLocalSourceImplementation extends SignUpLocalSource {
  const SignUpLocalSourceImplementation({required SharedPreferences sharedPreferences}) : _sharedPreferences = sharedPreferences;

  final SharedPreferences _sharedPreferences;

  @override
  saveToken(String token) async {
    return await _sharedPreferences.setString("token", token);
  }

  @override
  saveUserDetails(SignUpDetailsModel signUpDetailsModel) async {
    UsersModel user = UsersModel(
      email: signUpDetailsModel.email,
      name: signUpDetailsModel.name,
      phone: signUpDetailsModel.phone,
    );
    final r = await _sharedPreferences.setStringList("user_data", user.toListString());
    print(_sharedPreferences.getStringList("user_data"));
    print("-=============----------=====================================================================================");
  }
}
