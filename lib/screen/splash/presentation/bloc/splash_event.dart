import 'package:equatable/equatable.dart';
import 'package:flutter/animation.dart';

abstract class SplashEvent extends Equatable {
  const SplashEvent();
}

class OnRetrievedUserSplashEvent extends SplashEvent {
  const OnRetrievedUserSplashEvent({required this.onDone});

  final Function(String, bool) onDone;

  @override
  List<Object?> get props => [];
}
