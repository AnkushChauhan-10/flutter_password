import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:password/core/utiles/typedef.dart';

abstract class FetchDataOnlineSource {
  const FetchDataOnlineSource();

  Future<List<DataMap>> getData(String path, int lastUpdate);

  Future<num> getLastUpdate(String path);

  Stream<dynamic> lastUpdate(String path);
}

class FetchDataOnlineSourceImplementation extends FetchDataOnlineSource {
  const FetchDataOnlineSourceImplementation({required FirebaseFirestore fireStore}) : _fireStore = fireStore;
  final FirebaseFirestore _fireStore;

  @override
  Future<List<DataMap>> getData(String path, int lastUpdate) async {
    List<DataMap> list = [];
    print(lastUpdate);
    final ref = _fireStore.collection(path);
    await ref.where("last_update", isGreaterThan: lastUpdate).get().then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          if (docSnapshot.id != "user_data") {
            list.add(docSnapshot.data());
          }
        }
      },
    );
    return list;
  }

  @override
  Future<num> getLastUpdate(String path) async {
    return await _fireStore.collection(path).doc("user_data").get().then((value) => value.get("last_update"));
  }

  @override
  Stream lastUpdate(String path) {
    return _fireStore.collection(path).doc("user_data").snapshots();
  }
}
