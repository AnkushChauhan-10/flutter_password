import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password/core/response/response.dart';
import 'package:password/core/utiles/validation.dart';
import 'package:password/screen/sign_in/domain/use_case/sign_in.dart';
import 'package:password/screen/sign_in/presentation/bloc/sign_in_event.dart';
import 'package:password/screen/sign_in/presentation/bloc/sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc({required SignIn signIn})
      : _signIn = signIn,
        super(const SignInState.initState()) {
    on<OnSignInEvent>(_singInEvent);
  }

  final SignIn _signIn;

  Future<void> _singInEvent(OnSignInEvent event, Emitter<SignInState> emit) async {
    if (validateEmail(event.email) == null && validatePassword(event.password) == null) {
      emit(state.copyWith(isLoading: true, error: null));
      SignInParams params = SignInParams(
        email: event.email,
        password: event.password,
      );
      final result = await _signIn(params);
      if (result is SuccessResponse) {
        event.onDone.call();
      } else {
        print(result.data);
        emit(state.copyWith(error: result.data, isLoading: false));
      }
    }
  }
}
