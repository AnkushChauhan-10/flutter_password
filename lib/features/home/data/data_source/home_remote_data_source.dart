import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:password/features/home/data/models/account_data_model.dart';

abstract class HomeRemoteDataSource {
  const HomeRemoteDataSource();

  Future<List<AccountDataModel>> getAccountList(String path);

  Future<bool> deleteAccount(String path, String siteName);

  Future<int> getLastUpdate(String path);
}

class HomeRemoteDataSourceImplementation extends HomeRemoteDataSource {
  const HomeRemoteDataSourceImplementation({required FirebaseFirestore fireStore}) : _fireStore = fireStore;

  final FirebaseFirestore _fireStore;

  @override
  Future<List<AccountDataModel>> getAccountList(String path) async {
    List<AccountDataModel> list = [];
    final ref = _fireStore.collection(path);
    await ref.get().then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          if (docSnapshot.id != "user_data") {
            var account = AccountDataModel.fromMap(docSnapshot.data());
            list.add(account);
          }
        }
      },
      onError: (e) => throw Exception(),
    );
    return list;
  }

  @override
  Future<bool> deleteAccount(String path, String siteName) async {
    final ref = _fireStore.collection(path);
    await ref.doc(siteName).delete();
    return true;
  }

  @override
  Future<int> getLastUpdate(String path) async {
    final result = await _fireStore.collection(path).doc("user_data").get();
    var date = result.data()?["last_update"];
    return date;
  }
}
