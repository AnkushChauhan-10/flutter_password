import 'package:password/screen/sign_up/domain/entities/sign_up.dart';

class SignUpDetailsModel extends SignUpDetails {
  const SignUpDetailsModel({
    required super.email,
    required super.name,
    required super.phone,
    required super.password,
  });
}
