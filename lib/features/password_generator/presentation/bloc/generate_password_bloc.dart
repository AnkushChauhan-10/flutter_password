import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password/features/password_generator/presentation/bloc/generate_password_event.dart';
import 'package:password/features/password_generator/presentation/bloc/generate_password_state.dart';

class GeneratePasswordBloc extends Bloc<GeneratePasswordEvent, GeneratePasswordState> {
  GeneratePasswordBloc() : super(const GeneratePasswordState.initState()) {
    on<OnChangeLength>(_onChangeLength);
    on<OnChangeUpperCase>(_onChangeUpperCase);
    on<OnChangeLowerCase>(_onChangeLowerCase);
    on<OnChangeDigit>(_onChangeDigit);
    on<OnChangeSymbols>(_onChangeSymbols);
  }

  Future<void> _onChangeLength(OnChangeLength event, Emitter<GeneratePasswordState> emit) async {
    emit(state.copyWith(passwordLength: event.length));
    var password = state.generatePassword();
    emit(state.copyWith(password: password));
    event.onDone.call(password);
  }

  Future<void> _onChangeUpperCase(OnChangeUpperCase event, Emitter<GeneratePasswordState> emit) async {
    emit(state.copyWith(upperCase: event.upperCase));
    var password = state.generatePassword();
    emit(state.copyWith(password: password));
    event.onDone.call(password);
  }

  Future<void> _onChangeLowerCase(OnChangeLowerCase event, Emitter<GeneratePasswordState> emit) async {
    emit(state.copyWith(lowerCase: event.lowerCase));
    var password = state.generatePassword();
    emit(state.copyWith(password: password));
    event.onDone.call(password);
  }

  Future<void> _onChangeDigit(OnChangeDigit event, Emitter<GeneratePasswordState> emit) async {
    emit(state.copyWith(digits: event.digit));
    var password = state.generatePassword();
    emit(state.copyWith(password: password));
    event.onDone.call(password);
  }

  Future<void> _onChangeSymbols(OnChangeSymbols event, Emitter<GeneratePasswordState> emit) async {
    emit(state.copyWith(symbols: event.symbols));
    var password = state.generatePassword();
    emit(state.copyWith(password: password));
    event.onDone.call(password);
  }
}
