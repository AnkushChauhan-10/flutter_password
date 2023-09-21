import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password/core/response/response.dart';
import 'package:password/core/utiles/validation.dart';
import 'package:password/features/sign_up/domain/use_case/sign_up.dart';
import 'package:password/features/sign_up/presentation/bloc/sign_up_event.dart';
import 'package:password/features/sign_up/presentation/bloc/sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc({required SignUp signUp})
      : _signUp = signUp,
        super(const SignUpState.initState()) {
    on<OnSignUpEvent>(_singUpEvent);
  }

  final SignUp _signUp;

  Future<void> _singUpEvent(OnSignUpEvent event, Emitter<SignUpState> emit) async {
    if (validateName(event.name) == null &&
        validatePassword(event.password) == null &&
        validateEmail(event.email) == null &&
        validateConfirmPassword(event.password, event.confirmPassword) == null)
    {
      emit(state.copyWith(isLoading: true));
      SingUpParams params = SingUpParams(
        email: event.email,
        name: event.name,
        password: event.password,
        phone: event.phone,
      );
      final result = await _signUp(params);
      if(result is SuccessResponse) {
        event.onDone.call();
      }else{
        emit(state.copyWith(error: true,isLoading: false));
      }
    }
  }
}
