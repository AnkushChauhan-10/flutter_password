import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:password/core/utiles/typedef.dart';

abstract class EditDataSourceRepo {
  dynamic editData(String path, DataMap data);
  lastUpdate(num date,String path);
}

class EditDataSourceRepoImplementation extends EditDataSourceRepo {
  EditDataSourceRepoImplementation({required this.fireStore});

  final FirebaseFirestore fireStore;

  @override
  editData(String path, DataMap data) async {
    final ref = fireStore.collection(path).doc(data["title"]);
    await ref.set(data);
    return "saved";
  }

  @override
  lastUpdate(num date,String path) async {
    final ref = fireStore.collection(path).doc("user_data");
    await ref.update({"last_update":date});
  }
}
