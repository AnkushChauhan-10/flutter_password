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
  })  : _getUserData = getUserData,
        super(const HomeState.initialState()) {
    on<GetUserDataHomeEvent>(_getUserDataHomeEvent);
  }

  final GetUserData _getUserData;

  Future<void> _getUserDataHomeEvent(GetUserDataHomeEvent event, Emitter<HomeState> emit) async {
    final result = await _getUserData();
    if (result is SuccessResponse) {
      UsersModel model = result.data;
      emit(state.copyWith(name: model.name, email: model.email));
    }
  }
}
