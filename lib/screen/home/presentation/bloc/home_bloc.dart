import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password/core/model/users.dart';
import 'package:password/core/model/users.dart';
import 'package:password/core/response/response.dart';
import 'package:password/screen/home/domain/use_case/users_list.dart';
import 'package:password/screen/home/presentation/bloc/home_event.dart';
import 'package:password/screen/home/presentation/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required GetUsers getUsers,
    required GetLoggedUser getLoggedUser,
    required ChangeAccount changeAccount,
  })  : _getUsers = getUsers,
        _getLoggedUser = getLoggedUser,
        _changeAccount = changeAccount,
        super(const HomeState.initialState()) {
    on<GetUsersHomeEvent>(_getUsersHomeEvent);
    on<OnChangeLoggedUserHomeEvent>(_onChangeLoggedUserHomeEvent);
  }

  final GetUsers _getUsers;
  final GetLoggedUser _getLoggedUser;
  final ChangeAccount _changeAccount;

  Future<void> _getUsersHomeEvent(GetUsersHomeEvent event, Emitter<HomeState> emit) async {
    final result = await _getUsers();
    emit(state.copyWith(isLoading: true));
    if (result is SuccessResponse) {
      List<UsersModel> users = result.data;
      final token = await _getLoggedUser();
      UsersModel? logged;
      users.forEach((element) {
        element.token == token.data ? logged = element : null;
      });
      List<UsersModel> accounts = [];
      accounts.addAll(users);
      accounts.remove(logged);
      emit(state.copyWith(isLoading: false, users: users, loggedUser: logged, accounts: accounts));
    } else if (result is FailureResponse) {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onChangeLoggedUserHomeEvent(OnChangeLoggedUserHomeEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _changeAccount.call(event.token);
    if(result is SuccessResponse){
      event.onDone.call();
      emit(state.copyWith(isLoading: false));
    }
  }
}
