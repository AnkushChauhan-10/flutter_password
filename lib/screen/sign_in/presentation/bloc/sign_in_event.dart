import 'dart:ui';

import 'package:equatable/equatable.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();
}

class OnSignInEvent extends SignInEvent {
  const OnSignInEvent({
    required this.email,
    required this.password,
    required this.onDone,
  });

  final String email;
  final String password;
  final Function onDone;

  @override
  List<Object?> get props => [];
}
