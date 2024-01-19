import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:password/core/utiles/typedef.dart';

abstract class UpdateRemoteDataSource {
  const UpdateRemoteDataSource();

  Future<bool> update(DataMap map, String path);
}

class UpdateRemoteDataSourceImplementation extends UpdateRemoteDataSource {
  const UpdateRemoteDataSourceImplementation({required FirebaseFirestore firebaseFirestore}) :_firebaseFirestore = firebaseFirestore;

  final FirebaseFirestore _firebaseFirestore;

  @override
  Future<bool> update(DataMap map, String path) async {
    await _firebaseFirestore.collection(path).doc(map["title"]).update(map);
    return true;
  }

}