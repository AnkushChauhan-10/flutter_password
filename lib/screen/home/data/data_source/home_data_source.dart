import 'package:password/core/model/users.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

abstract class HomeDataSource {
  const HomeDataSource();

  String getToken();

  UsersModel getUserData();

}

class HomeDataSourceImplementation extends HomeDataSource {
  const HomeDataSourceImplementation({
    required SharedPreferences sharedPreferences,
    required Database dataBase,
  })  : _preferences = sharedPreferences,
        _db = dataBase;

  final SharedPreferences _preferences;
  final Database _db;

  @override
  String getToken() {
    final result = _preferences.getString('token') ?? " ";
    return result;
  }

  @override
  UsersModel getUserData() {
    List<String>? result = _preferences.getStringList("user_data");
    return UsersModel.fromListString(result!);
  }

}
