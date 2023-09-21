import 'package:equatable/equatable.dart';

class SignInDetails extends Equatable {
  const SignInDetails({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object?> get props => [email];
}
