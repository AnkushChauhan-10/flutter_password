import 'dart:async';

import 'package:password/core/utiles/typedef.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  DataBaseHelper({required Database database}) : _db = database;
  final Database _db;

  final StreamController<List<DataMap>> _streamController = StreamController<List<DataMap>>.broadcast();

  String tableName = '';

  Future<bool> createTable(String token) async {
    String tableName = token;
    const columnTitle = 'title';
    const columnUserName = 'user_id';
    const columnPassword = "password";
    const columnLastUpdate = "last_update";
    try {
      await _db.execute('''
                CREATE TABLE $tableName(
                $columnTitle TEXT NOT NULL PRIMARY KEY,
                $columnUserName TEXT NOT NULL,
                $columnPassword TEXT NOT NULL,
                $columnLastUpdate INTEGER NOT NULL
                )
              ''');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteTable(String table) async {
    try {
      final res = await _db.execute("DROP TABLE IF EXISTS $tableName");
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> insert(DataMap value, String table) async {
    try {
      final res = await _db.insert(table, value, conflictAlgorithm: ConflictAlgorithm.replace);
      updateStream(table);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> delete({required DataMap value, required String table, required String where}) async {
    try {
      final res = await _db.delete(table, where: "$where = ?", whereArgs: [value[where]]);
      updateStream(table);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteAll({required List<DataMap> data, required String table, required String where}) async {
    for (var i in data) {
      final res = await delete(value: i, table: table, where: where);
      if (!res) return false;
    }
    return true;
  }

  Future<bool> insertAll(List<DataMap> data, String table) async {
    for (var i in data) {
      final res = await insert(i, table);
      if (!res) return false;
    }
    return true;
  }

  Future<List<DataMap>> get(String tableName) async {
    List<DataMap> result = await _db.query(tableName);
    return result;
  }

  Stream<List<DataMap>> streamDB(String tableName) {
    this.tableName = tableName;
    updateStream(tableName);
    return _streamController.stream;
  }

  Future<void> updateStream(String table) async {
    if (tableName != table) return;
    List<DataMap> list = [];
    list.addAll(await get(tableName));
    list.sort((b, a) => a["last_update"].compareTo(b["last_update"]));
    _streamController.add(list);
  }
}

Future<Database> getDB() async {
  const databaseName = "password_database.db";
  const dbVersion = 1;

  const tableUser = 'users_table';
  const userName = 'name';
  const userId = 'email';
  const userToken = 'token';

  return await openDatabase(
    databaseName,
    version: dbVersion,
    onCreate: (Database db, int version) async {
      await db.execute('''
                CREATE TABLE $tableUser(
                $userId TEXT NOT NULL PRIMARY KEY,
                $userName TEXT NOT NULL,
                $userToken TEXT NOT NULL
                )
              ''');
    },
  );
}
