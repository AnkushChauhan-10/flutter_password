import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password/core/model/users.dart';
import 'package:password/core/response/response.dart';
import 'package:password/features/home/domain/use_case/get_account_list.dart';
import 'package:password/features/home/presentation/bloc/home_event.dart';
import 'package:password/features/home/presentation/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required GetAccountList getAccountList,
    required GetUserData getUserData,
    required SignOut signOut,
    required DeleteAccount deleteAccount,
  })  : _getAccountList = getAccountList,
        _signOut = signOut,
        _getUserData = getUserData,
        _deleteAccount = deleteAccount,
        super(const HomeState.initialState()) {
    on<OnGetListHomeEvent>(_onGetListHomeEvent);
    on<GetUserDataHomeEvent>(_getUserDataHomeEvent);
    on<OnSignOutHomeEvent>(_onSignOutHomeEvent);
    on<OnDeleteAccount>(_onDeleteAccount);
  }

  final GetAccountList _getAccountList;
  final GetUserData _getUserData;
  final SignOut _signOut;
  final DeleteAccount _deleteAccount;

  Future<void> _onGetListHomeEvent(OnGetListHomeEvent event, Emitter<HomeState> emit) async {
    final result = await _getAccountList();
    if (result is SuccessResponse) {
      emit(state.copyWith(isLoading: false, list: result.data));
    }
    if (result is FailureResponse) {
      print("faild ${result.data}");
    }
  }

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

  Future<void> _onDeleteAccount(OnDeleteAccount event, Emitter<HomeState> emit) async {
    var delete = state.list.removeAt(event.index);
    _deleteAccount(delete.siteName);
    emit(state.copyWith(list: state.list));
  }
}
