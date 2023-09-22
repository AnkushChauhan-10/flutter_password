import 'package:cloud_firestore/cloud_firestore.dart';

abstract class RemoteDeleteDataSource {
  const RemoteDeleteDataSource();

  Future<bool> deleteData(String name, String path);
}

class RemoteDeleteDataSourceImplementation extends RemoteDeleteDataSource {
  const RemoteDeleteDataSourceImplementation({required FirebaseFirestore firebaseFirestore}) : _firebaseFirestore = firebaseFirestore;

  final FirebaseFirestore _firebaseFirestore;

  @override
  Future<bool> deleteData(String name, String path) async{
    await _firebaseFirestore.collection(path).doc(name).delete();
    return true;
  }
}
