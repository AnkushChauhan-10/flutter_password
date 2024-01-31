import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class GetUsersHomeEvent extends HomeEvent {
  const GetUsersHomeEvent();

  @override
  List<Object?> get props => [];
}

class OnChangeLoggedUserHomeEvent extends HomeEvent {
  const OnChangeLoggedUserHomeEvent(this.token, this.onDone);

  final String token;
  final Function onDone;

  @override
  List<Object?> get props => [token];
}
