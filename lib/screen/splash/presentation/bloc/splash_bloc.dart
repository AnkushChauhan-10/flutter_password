import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password/core/utiles/const.dart';
import 'package:password/screen/splash/domain/use_case/is_user_logged_in.dart';
import 'package:password/screen/splash/presentation/bloc/splash_event.dart';
import 'package:password/screen/splash/presentation/bloc/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc({required IsUserLoggedIn isUserLoggedIn, required IsLockSet isLockSet})
      : _isUserLoggedIn = isUserLoggedIn,
        _isLockSet = isLockSet,
        super(const SplashState.initState()) {
    on<OnRetrievedUserSplashEvent>(_onRetrievedUserSplashEvent);
  }

  final IsUserLoggedIn _isUserLoggedIn;
  final IsLockSet _isLockSet;

  Future<void> _onRetrievedUserSplashEvent(OnRetrievedUserSplashEvent event, Emitter<SplashState> emit) async {
    final result = _isUserLoggedIn();
    final isLock = _isLockSet();
    if (result) {
      emit(state.copyWith(retrievedUser: true, nextPage: homePageRoute, completeSplash: true, isLock: isLock));
    } else {
      emit(state.copyWith(retrievedUser: true, nextPage: signInPageRoute, completeSplash: true, isLock: isLock));
    }
    if (state.completeSplash) {
      event.onDone.call(state.nextPage, isLock);
    }
  }
}
