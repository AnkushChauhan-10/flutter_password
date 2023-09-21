import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:password/screen/home/data/models/account_data_model.dart';

abstract class HomeRemoteDataSource {
  const HomeRemoteDataSource();
  Future<int> getLastUpdate(String path);
}

class HomeRemoteDataSourceImplementation extends HomeRemoteDataSource {
  const HomeRemoteDataSourceImplementation({required FirebaseFirestore fireStore}) : _fireStore = fireStore;

  final FirebaseFirestore _fireStore;

  @override
  Future<int> getLastUpdate(String path) async {
    final result = await _fireStore.collection(path).doc("user_data").get();
    var date = result.data()?["last_update"];
    return date;
  }
}
