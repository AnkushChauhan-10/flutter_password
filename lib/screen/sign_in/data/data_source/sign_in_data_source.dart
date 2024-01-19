import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:password/core/model/users.dart';
import 'package:password/core/utiles/typedef.dart';
import 'package:password/screen/sign_in/data/models/sign_in_details_model.dart';

abstract class SignInDataSource {
  const SignInDataSource();

  singIn(SignInDetailsModel model);

  getUser(String path);
}

class SignInDataSourceImplementation extends SignInDataSource {
  const SignInDataSourceImplementation({required FirebaseAuth firebaseAuth, required FirebaseFirestore firebaseFirestore})
      : _firebaseAuth = firebaseAuth,
        _firebaseFirestore = firebaseFirestore;

  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  @override
  singIn(SignInDetailsModel model) async {
    print("before");
    UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
      email: model.email,
      password: model.password,
    );
    print("after");
    return result.user!.uid;
  }

  @override
  getUser(String path) async {
    DataMap? result;
    final ref = _firebaseFirestore.collection(path);
    final data = await ref.doc("user_data").get();
    result = data.data();
    return UsersModel.fromMap(result!).toListString();
  }

  Future<void> verifyOTP(String verificationId, String smsCode) async {
    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      print("Verify otp ${credential}");
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      final User? user = userCredential.user;
    } catch (e) {
      print("Verify otp ${e.toString()}");
    }
  }
}
