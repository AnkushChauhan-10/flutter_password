import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password/core/utiles/const.dart';
import 'package:password/screen/splash/domain/use_case/is_user_logged_in.dart';
import 'package:password/screen/splash/presentation/bloc/splash_event.dart';
import 'package:password/screen/splash/presentation/bloc/splash_state.dart';


class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc({required IsUserLoggedIn isUserLoggedIn})
      : _isUserLoggedIn = isUserLoggedIn,
        super(const SplashState.initState()) {
    on<OnCompleteSplashEvent>(_onCompleteSplashEvent);
    on<OnRetrievedUserSplashEvent>(_onRetrievedUserSplashEvent);
  }

  final IsUserLoggedIn _isUserLoggedIn;

  Future<void> _onCompleteSplashEvent(OnCompleteSplashEvent event, Emitter<SplashState> emit) async {
    if(state.completeSplash == false){
      await Future.delayed(const Duration(seconds: 3));
      emit(state.copyWith(completeSplash: true));
      if(state.retrievedUser) {
        event.onDone.call(state.nextPage);
      }
    }
  }

  Future<void> _onRetrievedUserSplashEvent(OnRetrievedUserSplashEvent event, Emitter<SplashState> emit) async {
    if(state.retrievedUser == false){
      final result = _isUserLoggedIn();
      if(result){
        emit(state.copyWith(retrievedUser: true,nextPage: homePageRoute));
      }else{
        emit(state.copyWith(retrievedUser: true,nextPage: signInPageRoute));
      }
      if(state.completeSplash) {
        event.onDone.call(state.nextPage);
      }
    }
  }
}
