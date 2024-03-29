import 'package:equatable/equatable.dart';

class SignUpDetails extends Equatable{

  const SignUpDetails({required this.email, required this.name, required this.password});

  final String email;
  final String name;
  final String password;


  @override
  List<Object?> get props => [email];

}