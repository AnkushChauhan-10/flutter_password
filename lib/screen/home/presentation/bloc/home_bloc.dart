import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password/core/model/users.dart';
import 'package:password/core/response/response.dart';
import 'package:password/screen/home/domain/use_case/get_account_list.dart';
import 'package:password/screen/home/presentation/bloc/home_event.dart';
import 'package:password/screen/home/presentation/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required GetUserData getUserData,
    required SignOut signOut,
  })  : _signOut = signOut,
        _getUserData = getUserData,
        super(const HomeState.initialState()) {
    on<GetUserDataHomeEvent>(_getUserDataHomeEvent);
    on<OnSignOutHomeEvent>(_onSignOutHomeEvent);
  }

  final GetUserData _getUserData;
  final SignOut _signOut;

  Future<void> _getUserDataHomeEvent(GetUserDataHomeEvent event, Emitter<HomeState> emit) async {
    final result = await _getUserData();
    if (result is SuccessResponse) {
      UsersModel model = result.data;
      emit(state.copyWith(name: model.name, email: model.email));
    }
  }

  Future<void> _onSignOutHomeEvent(OnSignOutHomeEvent event, Emitter<HomeState> emit) async {
    await _signOut();
    event.onDone.call();
  }

}
