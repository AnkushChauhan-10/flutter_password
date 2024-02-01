import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password/core/utiles/const.dart';
import 'package:password/screen/splash/domain/use_case/is_user_logged_in.dart';
import 'package:password/screen/splash/presentation/bloc/splash_event.dart';
import 'package:password/screen/splash/presentation/bloc/splash_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc({required IsUserLoggedIn isUserLoggedIn})
      : _isUserLoggedIn = isUserLoggedIn,
        super(const SplashState.initState()) {
    on<OnRetrievedUserSplashEvent>(_onRetrievedUserSplashEvent);
  }

  final IsUserLoggedIn _isUserLoggedIn;

  Future<void> _onRetrievedUserSplashEvent(OnRetrievedUserSplashEvent event, Emitter<SplashState> emit) async {
    final sp = await SharedPreferences.getInstance();
    final result = _isUserLoggedIn();
    if (result) {
      emit(state.copyWith(retrievedUser: true, nextPage: homePageRoute, completeSplash: true));
    } else {
      emit(state.copyWith(retrievedUser: true, nextPage: signInPageRoute, completeSplash: true));
    }
    if (state.completeSplash) {
      event.onDone.call(state.nextPage);
    }
  }
}
