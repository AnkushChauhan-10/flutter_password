import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:password/core/model/users.dart';
import 'package:password/features/sign_up/data/models/SingUpDetailsModel.dart';

abstract class SignUpDataSource {
  const SignUpDataSource();

  singUp(SignUpDetailsModel model);

  saveUser(SignUpDetailsModel model, String path);
}

class SignUpDataSourceImplementation extends SignUpDataSource {
  const SignUpDataSourceImplementation({required FirebaseAuth firebaseAuth, required FirebaseFirestore firebaseFirestore})
      : _firebaseAuth = firebaseAuth,
        _firebaseFirestore = firebaseFirestore;

  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  @override
  singUp(SignUpDetailsModel model) async {
    UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(
      email: model.email,
      password: model.password,
    );
    return result.user?.uid;
  }

  @override
  saveUser(SignUpDetailsModel model, String path) async {
    UsersModel usersModel = UsersModel(email: model.email, name: model.name, phone: model.phone);
    final doc = _firebaseFirestore.collection(path).doc("user_data");
    await doc.set(usersModel.toMap());
    return "saved";
  }
}
