import 'package:equatable/equatable.dart';

abstract class SplashEvent extends Equatable {
  const SplashEvent();
}

class OnCompleteSplashEvent extends SplashEvent {
  const OnCompleteSplashEvent({required this.onDone});

  final Function(String) onDone;

  @override
  List<Object?> get props => [];
}

class OnRetrievedUserSplashEvent extends SplashEvent {
  const OnRetrievedUserSplashEvent({required this.onDone});

  final Function(String) onDone;

  @override
  List<Object?> get props => [];
}
