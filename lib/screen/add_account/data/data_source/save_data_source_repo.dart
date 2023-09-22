import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:password/core/utiles/typedef.dart';

abstract class SaveDataSourceRepo {
  dynamic saveData(String path, DataMap data);
  lastUpdate(int date,String path);
}

class SaveDataSourceRepoImplementation extends SaveDataSourceRepo {
  SaveDataSourceRepoImplementation({required this.fireStore});

  final FirebaseFirestore fireStore;

  @override
  saveData(String path, DataMap data) async {
    final ref = fireStore.collection(path).doc(data["title"]);
    await ref.set(data);
    return "saved";
  }

  @override
  lastUpdate(int date,String path) async {
    final ref = fireStore.collection(path).doc("user_data");
    await ref.update({"last_update":date});
  }
}
