import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:password/core/utiles/typedef.dart';

abstract class ShowAccountsListRemoteDataSource {
  const ShowAccountsListRemoteDataSource();

  Future<List<DataMap>> getAccountList(String path);
}

class ShowAccountsListRemoteDataSourceImplementation extends ShowAccountsListRemoteDataSource {
  const ShowAccountsListRemoteDataSourceImplementation({required FirebaseFirestore fireStore}) : _fireStore = fireStore;

  final FirebaseFirestore _fireStore;

  @override
  Future<List<DataMap>> getAccountList(String path) async {
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
}
