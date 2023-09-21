import 'package:password/core/utiles/typedef.dart';
import 'package:password/screen/sign_in/domain/entities/sign_in_details.dart';

abstract class SignInRepository{
  const SignInRepository();

  FutureResponse sigIn({required SignInDetails user});
}