import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password/core/response/response.dart';
import 'package:password/features/show_accounts_list/domain/use_case/get_account_list.dart';
import 'package:password/features/show_accounts_list/presentation/bloc/show_accounts_list_event.dart';
import 'package:password/features/show_accounts_list/presentation/bloc/show_accounts_list_state.dart';

class ShowAccountsListBloc extends Bloc<ShowAccountsListEvent, ShowAccountsListState> {
  ShowAccountsListBloc({
    required GetShowAccountsList getShowAccountsList,
  })  : _getAccountList = getShowAccountsList,
        super(const ShowAccountsListState.initialState()) {
    on<OnGetShowAccountsListEvent>(_onGetShowAccountsListEvent);
  }

  final GetShowAccountsList _getAccountList;

  Future<void> _onGetShowAccountsListEvent(OnGetShowAccountsListEvent event, Emitter<ShowAccountsListState> emit) async {
    final result = await _getAccountList();
    emit(state.copyWith(state: true, isLoading: true));
    if (result is SuccessResponse) {
      print("========================================${result}");
      emit(state.copyWith(isLoading: false, list: result.data));
    }
    if (result is FailureResponse) {
      emit(state.copyWith(isLoading: false));
      print("faild ${result.data}");
    }
  }
}
