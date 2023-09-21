import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:password/core/utiles/typedef.dart';

abstract class RemoteUpdateDataSource {
  const RemoteUpdateDataSource();

  Future<bool> updateFireBase(List<DataMap> map, String path);

  Future<List<DataMap>> getAccountList(String path, int lastUpdate);

  Future<int> getLastUpdate(String path);
}

class RemoteUpdateDataSourceImplementation extends RemoteUpdateDataSource {
  const RemoteUpdateDataSourceImplementation({required FirebaseFirestore fireStore}) : _fireStore = fireStore;

  final FirebaseFirestore _fireStore;

  @override
  Future<List<DataMap>> getAccountList(String path,  int lastUpdate) async {
    List<DataMap> list = [];
    final ref = _fireStore.collection(path);
    await ref.get().then(
          (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          if (docSnapshot.id != "user_data") {
            list.add(docSnapshot.data());
          }
        }
      },
      onError: (e) => throw Exception(),
    );
    return list;
  }

  @override
  Future<int> getLastUpdate(String path) async {
    final result = await _fireStore.collection(path).doc("user_data").get();
    var date = result.data()?["last_update"];
    return date;
  }

  @override
  Future<bool> updateFireBase(List<DataMap> map, String path) async {
    for (var element in map) {
      final ref = _fireStore.collection(path).doc(element["site_name"]);
      await ref.set(element);
    }
    return true;
  }
}