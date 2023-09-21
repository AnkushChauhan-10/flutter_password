import 'package:sqflite/sqflite.dart';

Future<Database> getDB() async {
  const databaseName = "password_database.db";
  const dbVersion = 1;
  const tableName = "account_table";

  const columnSiteName = 'site_name';
  const columnUserId = 'id';
  const columnUserName = 'user_name';
  const columnPassword = "password";
  const columnLastUpdate = "last_update";
  const columnIsUpdate = "is_update";
  return await openDatabase(
    databaseName,
    version: dbVersion,
    onCreate: (Database db, int version) async {
      await db.execute('''
                CREATE TABLE $tableName(
                $columnSiteName TEXT NOT NULL PRIMARY KEY,
                $columnUserId TEXT NOT NULL,
                $columnUserName TEXT NOT NULL,
                $columnPassword TEXT NOT NULL,
                $columnLastUpdate TEXT NOT NULL,
                $columnIsUpdate INTEGER NOT NULL
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
