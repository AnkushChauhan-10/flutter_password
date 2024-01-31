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

  Future<bool> insert(DataMap value, String table) async {
    try {
      final res = await _db.insert(table, value, conflictAlgorithm: ConflictAlgorithm.replace);
      updateStream(table);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> delete(DataMap value, String table) async {
    try {
      final res = await _db.delete(table, where: "title = ?", whereArgs: [value['title']]);
      updateStream(table);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteAll(List<DataMap> data, String table) async {
    for (var i in data) {
      final res = await delete(i, table);
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
    List<DataMap> list = await get(tableName);
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

  // @override
  // Future<void> insert(Account account) async {
  //   var db = await getDB();
  //   await db!.insert(
  //     tableName,
  //     {
  //       columnSiteName: account.siteName,
  //       columnUserId: account.id,
  //       columnUserName: account.userName,
  //       columnPassword: account.password,
  //       columnLastUpdate: account.lastUpdate,
  //     },
  //   );
  // }

/*Future<void> delete(Model std) async{
    var db = await getDB();
    await db!.delete(tableName,where: '$column_id = ?',whereArgs: [std.id]);
  }

  Future<void> update(Model std) async{
    var db = await getDB();
    await db!.update(tableName, {column_id:std.id,column_name:std.name,column_phone:std.phone,column_email:std.email},
        where: '$column_id = ?',whereArgs: [std.id]);
  }

  Future<List<Model>> getList() async{
    var db = await getDB();
    List<Map<String,dynamic>> res  = await db!.query(tableName);
    return List.generate(res.length, (index)=> Model(
        id: res[index][column_id],
        name: res[index][column_name],
        phone: res[index][column_phone],
        email: res[index][column_email] ?? "null" )
    );
  }*/
}
