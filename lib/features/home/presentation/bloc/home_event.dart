import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class GetUserDataHomeEvent extends HomeEvent {
  const GetUserDataHomeEvent();

  @override
  List<Object?> get props => [];
}

class OnGetListHomeEvent extends HomeEvent {
  const OnGetListHomeEvent();

  @override
  List<Object?> get props => [];
}

class OnDeleteAccount extends HomeEvent{
  const OnDeleteAccount({required this.index});
  final int index;
  @override
  List<Object?> get props => [];
}

class OnSignOutHomeEvent extends HomeEvent {
  const OnSignOutHomeEvent({required this.onDone});

  final Function onDone;
  @override
  List<Object?> get props => [];
}
