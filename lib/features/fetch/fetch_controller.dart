import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:password/core/response/response.dart';
import 'package:password/core/utiles/data_base_helper.dart';
import 'package:password/core/utiles/network_connectivity.dart';
import 'package:password/core/utiles/typedef.dart';
import 'package:password/screen/save_data/data/model/account_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FetchController extends GetxController {
  FetchController({
    required DataBaseHelper dataBaseHelper,
    required FirebaseFirestore firestore,
    required NetworkConnectivity networkConnectivity,
    required SharedPreferences sharedPreferences,
  })  : _db = dataBaseHelper,
        _preferences = sharedPreferences,
        _networkConnectivity = networkConnectivity,
        _fireStore = firestore;
  final DataBaseHelper _db;
  final FirebaseFirestore _fireStore;
  final SharedPreferences _preferences;
  final NetworkConnectivity _networkConnectivity;

  FutureResponse fetchDataBase() async {
    try {
      if (!await _networkConnectivity.isConnected()) return const SuccessResponse(false);
      String table = getToken();
      if (table.isEmpty) return const SuccessResponse(false);
      List<DataMap> map1 = await _db.get(table);
      List<AccountModel> local = List.generate(map1.length, (i) => AccountModel.fromMap(map1[i]));
      List<DataMap> map2 = [];
      await _fireStore.collection(table).get().then((value) {
        for (var docSnapshot in value.docs) {
          if (docSnapshot.id != "user_data") {
            map2.add(docSnapshot.data());
          }
        }
      });
      List<AccountModel> remote = List.generate(map2.length, (i) => AccountModel.fromMap(map2[i]));
      compareData(local, remote, table);
      return const SuccessResponse(true);
    } catch (e) {
      print(e);
      return FailureResponse(e);
    }
  }

  String getToken() {
    return _preferences.getString("token") ?? "";
  }

  void compareData(List<AccountModel> local, List<AccountModel> remote, String table) {
    print(local);
    print(remote);
    List<AccountModel> delete = [], insert = [];
    delete.addAll(local);
    insert.addAll(remote);
    int k = 0;
    for (var i in remote) {
      for (var j in local) {
        print(k);
        if (j.title == i.title) {
          if (i.lastUpdate > j.lastUpdate) {
            delete.remove(j);
          } else {
            insert.remove(j);
            delete.remove(j);
          }
        }
        print(insert);
        print(delete);
      }
    }
    _db.insertAll(List.generate(insert.length, (i) => insert[i].toMap()), table);
    _db.deleteAll(data: List.generate(delete.length, (i) => delete[i].toMap()), table: table, where: 'title');
  }
}
