import 'package:shared_preferences/shared_preferences.dart';

class LockRepository {
  const LockRepository({required SharedPreferences sharedPreferences}) : _sharedPreferences = sharedPreferences;
  final SharedPreferences _sharedPreferences;

  String lock() => _sharedPreferences.getString("lock") ?? "";
}
