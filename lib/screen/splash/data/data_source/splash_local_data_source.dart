import 'package:shared_preferences/shared_preferences.dart';

abstract class SplashLocalDataSource {
  const SplashLocalDataSource();

  String? getUserLoggedInData();

  String? lock();
}

class SplashLocalDataSourceImplementation extends SplashLocalDataSource {
  SplashLocalDataSourceImplementation({required SharedPreferences sharedPreferences}) : _sharedPreferences = sharedPreferences;

  final SharedPreferences _sharedPreferences;

  @override
  String? getUserLoggedInData() {
    return _sharedPreferences.getString("token");
  }

  @override
  String? lock() {
    return _sharedPreferences.getString("lock");
  }
}
