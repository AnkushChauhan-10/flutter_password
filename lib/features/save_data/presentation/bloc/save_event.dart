import 'package:equatable/equatable.dart';

abstract class SaveEvent extends Equatable {}

class OnChangeId extends SaveEvent {
  OnChangeId({required this.id});

  final String id;

  @override
  List<Object?> get props => [];
}

class OnChangeSiteName extends SaveEvent {
  OnChangeSiteName({required this.siteName});

  final String siteName;

  @override
  List<Object?> get props => [];
}

class OnChangePassword extends SaveEvent {
  OnChangePassword({required this.password});

  final String password;

  @override
  List<Object?> get props => [];
}

class OnChangeUserName extends SaveEvent {
  OnChangeUserName({required this.userName});

  final String userName;

  @override
  List<Object?> get props => [];
}

class OnSave extends SaveEvent {
  OnSave({
    required this.onDone,
    required this.siteName,
    required this.password,
    required this.userName,
    required this.id,
    required this.confirmPassword,
  });

  final String id;
  final String password;
  final String confirmPassword;
  final String siteName;
  final String userName;

  final Function onDone;

  @override
  List<Object?> get props => [];
}
