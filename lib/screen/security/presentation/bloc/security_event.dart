import 'package:equatable/equatable.dart';

abstract class SecurityEvent extends Equatable {
  const SecurityEvent();
}

class GetPinSecurityEvent extends SecurityEvent {
  const GetPinSecurityEvent();

  @override
  List<Object?> get props => [];
}

class SetPinSecurityEvent extends SecurityEvent {
  const SetPinSecurityEvent(this.pin);

  final String pin;

  @override
  List<Object?> get props => [];
}

class DeletePinSecurityEvent extends SecurityEvent {
  const DeletePinSecurityEvent();

  @override
  List<Object?> get props => [];
}
