import 'package:shared_preferences/shared_preferences.dart';

abstract class PinDataSource {
  const PinDataSource();

  String pin();

  Future<bool> setPin(String pin);

  Future<bool> deletePin();
}

class PinDataSourceImplementation extends PinDataSource {
  const PinDataSourceImplementation({required SharedPreferences sharedPreferences}) : _sharedPreferences = sharedPreferences;
  final SharedPreferences _sharedPreferences;

  @override
  Future<bool> deletePin() async => await _sharedPreferences.remove("lock");

  @override
  String pin() => _sharedPreferences.getString("lock") ?? "";

  @override
  Future<bool> setPin(String pin) async => await _sharedPreferences.setString("lock", pin);
}
