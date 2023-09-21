import 'package:password/core/utiles/typedef.dart';

import '../entities/sign_up.dart';

abstract class SignUpRepository{
  const SignUpRepository();

  FutureResponse singUp({required SignUpDetails user});
}