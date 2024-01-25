import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:password/core/utiles/typedef.dart';

abstract class ShowAccountsListRemoteDataSource {
  const ShowAccountsListRemoteDataSource();

  Stream<List<DataMap>> getAccountList(String path);

  Future<num> getLastUpdate(String path);
}

class ShowAccountsListRemoteDataSourceImplementation extends ShowAccountsListRemoteDataSource {
  const ShowAccountsListRemoteDataSourceImplementation({required FirebaseFirestore fireStore}) : _fireStore = fireStore;

  final FirebaseFirestore _fireStore;

  @override
  Stream<List<DataMap>> getAccountList(String path) {
    final ref = _fireStore.collection(path);
    return ref.snapshots().map(
      (querySnapshot) {
        List<DataMap> list = [];
        for (var docSnapshot in querySnapshot.docs) {
          if (docSnapshot.id != "user_data") {
            list.add(docSnapshot.data());
          }
        }
        return list;
      },
    );
  }

  @override
  Future<num> getLastUpdate(String path) async {
    return await _fireStore.collection(path).doc("user_data").get().then((value) => value.get("last_update"));
  }
}
