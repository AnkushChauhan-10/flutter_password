import 'package:equatable/equatable.dart';

abstract class UpdateEvent extends Equatable {}


class Set extends UpdateEvent{
  Set({
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

class OnUpdate extends UpdateEvent {
  OnUpdate({
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
