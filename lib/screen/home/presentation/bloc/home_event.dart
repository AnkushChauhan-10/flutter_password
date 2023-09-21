import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class GetUserDataHomeEvent extends HomeEvent {
  const GetUserDataHomeEvent();

  @override
  List<Object?> get props => [];
}

class OnSignOutHomeEvent extends HomeEvent {
  const OnSignOutHomeEvent({required this.onDone});

  final Function onDone;
  @override
  List<Object?> get props => [];
}
