import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password/core/response/response.dart';
import 'package:password/features/show_accounts_list/domain/entities/show_account.dart';
import 'package:password/features/show_accounts_list/domain/use_case/get_account_list.dart';
import 'package:password/features/show_accounts_list/presentation/bloc/show_accounts_list_event.dart';
import 'package:password/features/show_accounts_list/presentation/bloc/show_accounts_list_state.dart';

class ShowAccountsListBloc extends Bloc<ShowAccountsListEvent, ShowAccountsListState> {
  ShowAccountsListBloc({
    required GetShowAccountsList getShowAccountsList,
  })  : _getAccountList = getShowAccountsList,
        list = [],
        super(const ShowAccountsListState.initialState()) {
    final result = _getAccountList();
    subscription = result.listen((event) {
      if (event is SuccessResponse) {
        list = event.data;
      }
      print("--------------------------$list");
      add(const OnGetShowAccountsListEvent());
    });
    on<OnGetShowAccountsListEvent>(_onGetShowAccountsListEvent);
    on<OnSearchListEvent>(_onSearchListEvent);
  }

  final GetShowAccountsList _getAccountList;
  List<ShowAccount> list;
  late final StreamSubscription subscription;

  void _onGetShowAccountsListEvent(OnGetShowAccountsListEvent event, Emitter<ShowAccountsListState> emit) {
    emit(state.copyWith(state: true, isLoading: true));
    emit(state.copyWith(isLoading: false, list: list));
  }

  void _onSearchListEvent(OnSearchListEvent event, Emitter<ShowAccountsListState> emit) {
    if (event.text.isEmpty) {
      emit(state.copyWith(searchList: [], isSearch: false));
      return;
    }
    List<ShowAccount> temp = [];
    list.forEach((element) => element.title.toLowerCase().contains(event.text.toLowerCase()) ? temp.add(element) : null);
    emit(state.copyWith(searchList: temp, isSearch: true));
  }

  void pauseStream() => subscription.pause();

  void resumeStream() => subscription.resume();
}
