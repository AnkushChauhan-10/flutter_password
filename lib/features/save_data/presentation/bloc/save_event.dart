import 'package:equatable/equatable.dart';

abstract class SaveEvent extends Equatable {}

class OnChangeEmail extends SaveEvent {
  OnChangeEmail({required this.email});

  final String email;

  @override
  List<Object?> get props => [];
}

class OnChangeWebSiteURL extends SaveEvent {
  OnChangeWebSiteURL({required this.webSiteURL});

  final String webSiteURL;

  @override
  List<Object?> get props => [];
}

class OnChangeTitle extends SaveEvent {
  OnChangeTitle({required this.title});

  final String title;

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
    required this.password,
    required this.userName,
    required this.email,
    required this.title,
    required this.websiteURL,
  });

  final String email;
  final String websiteURL;
  final String password;
  final String title;
  final String userName;

  final Function onDone;

  @override
  List<Object?> get props => [];
}
