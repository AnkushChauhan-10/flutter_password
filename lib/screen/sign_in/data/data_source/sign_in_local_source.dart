import 'package:shared_preferences/shared_preferences.dart';

abstract class SignInLocalSource {
  const SignInLocalSource();

  saveToken(String token);

  saveUserDetails(List<String> user);
}

class SignInLocalSourceImplementation extends SignInLocalSource {
  const SignInLocalSourceImplementation({required SharedPreferences sharedPreferences}) : _sharedPreferences = sharedPreferences;

  final SharedPreferences _sharedPreferences;

  @override
  saveToken(String token) async {
    return await _sharedPreferences.setString("token", token);
  }

  @override
  saveUserDetails(List<String> user) async {
    var result = await _sharedPreferences.setStringList("user_data", user);
    return result;
  }
}
