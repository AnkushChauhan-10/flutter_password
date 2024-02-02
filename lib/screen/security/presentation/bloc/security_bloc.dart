import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password/core/response/response.dart';
import 'package:password/screen/security/domain/use_case.dart';
import 'package:password/screen/security/presentation/bloc/security_event.dart';
import 'package:password/screen/security/presentation/bloc/security_state.dart';

class SecurityBloc extends Bloc<SecurityEvent, SecurityState> {
  SecurityBloc({
    required Pin pin,
    required SetPin setPin,
    required DeletePin deletePin,
  })  : _pin = pin,
        _setPin = setPin,
        _deletePin = deletePin,
        super(const SecurityState.initState()) {
    on<GetPinSecurityEvent>(_getPinEvent);
    on<SetPinSecurityEvent>(_setPinEvent);
    on<DeletePinSecurityEvent>(_deletePinEvent);
  }

  final Pin _pin;
  final SetPin _setPin;
  final DeletePin _deletePin;

  void _getPinEvent(GetPinSecurityEvent event, Emitter<SecurityState> emit) {
    String pin = _pin();
    if (pin.isEmpty) {
      emit(state.copyWith(pin: "", isSetPin: false));
    } else {
      emit(state.copyWith(pin: pin, isSetPin: true));
    }
  }

  Future<void> _setPinEvent(SetPinSecurityEvent event, Emitter<SecurityState> emit) async {
    final result = await _setPin(event.pin);
    if (result is SuccessResponse) {
      emit(state.copyWith(pin: event.pin, isSetPin: true));
    }
  }

  Future<void> _deletePinEvent(DeletePinSecurityEvent event, Emitter<SecurityState> emit) async {
    final result = await _deletePin();
    if (result is SuccessResponse) {
      emit(state.copyWith(pin: "", isSetPin: false));
    }
  }
}
