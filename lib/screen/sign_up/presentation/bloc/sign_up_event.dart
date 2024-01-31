import 'dart:ui';

import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();
}

class OnSignUpEvent extends SignUpEvent {
  const OnSignUpEvent({
    required this.email,
    required this.password,
    required this.name,
    required this.onDone,
    required this.confirmPassword,
  });

  final String email;
  final String name;
  final String password;
  final String confirmPassword;
  final Function onDone;

  @override
  List<Object?> get props => [];
}
