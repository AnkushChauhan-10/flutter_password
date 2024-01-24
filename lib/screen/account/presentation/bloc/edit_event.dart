import 'package:equatable/equatable.dart';

abstract class EditEvent extends Equatable {}

class OnChangePassword extends EditEvent {
  OnChangePassword({required this.password});

  final String password;

  @override
  List<Object?> get props => [];
}

class OnChangeUserName extends EditEvent {
  OnChangeUserName({required this.userName});

  final String userName;

  @override
  List<Object?> get props => [];
}

class OnEdit extends EditEvent {
  OnEdit({
    required this.onDone,
    required this.password,
    required this.userName,
    required this.title,
  });

  final String password;
  final String title;
  final String userName;

  final Function onDone;

  @override
  List<Object?> get props => [];
}
