import 'package:password/core/utiles/typedef.dart';

abstract class SignOutRepository {
  const SignOutRepository();

  FutureResponse signOut();
}
