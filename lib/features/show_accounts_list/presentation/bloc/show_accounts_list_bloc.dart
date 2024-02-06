import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password/core/response/response.dart';
import 'package:password/features/show_accounts_list/data/models/show_account_model.dart';
import 'package:password/features/show_accounts_list/domain/entities/show_account.dart';
import 'package:password/features/show_accounts_list/domain/use_case/get_account_list.dart';
import 'package:password/features/show_accounts_list/presentation/bloc/show_accounts_list_event.dart';
import 'package:password/features/show_accounts_list/presentation/bloc/show_accounts_list_state.dart';
import 'package:password/screen/home/presentation/bloc/home_bloc.dart';

class ShowAccountsListBloc extends Bloc<ShowAccountsListEvent, ShowAccountsListState> {
  ShowAccountsListBloc({
    required GetShowAccountsList getShowAccountsList,
  })  : _getAccountList = getShowAccountsList,
        list = [],
        super(const ShowAccountsListState.initialState()) {
    on<OnGetShowAccountsListEvent>(_onGetShowAccountsListEvent);
    on<OnSearchListEvent>(_onSearchListEvent);
    on<SetStreamListEvent>(_setStreamListEvent);
  }

  final GetShowAccountsList _getAccountList;
  List<ShowAccountModel> list;
  StreamSubscription? streamController;

  Future<void> _onGetShowAccountsListEvent(OnGetShowAccountsListEvent event, Emitter<ShowAccountsListState> emit) async {
    emit(state.copyWith(isLoading: true));
    emit(state.copyWith(isLoading: false, list: list));
  }

  void _onSearchListEvent(OnSearchListEvent event, Emitter<ShowAccountsListState> emit) {
    if (event.text.isEmpty) {
      emit(state.copyWith(searchList: [], isSearch: false));
      return;
    }
    List<ShowAccountModel> temp = [];
    for (var element in list) {
      element.title.toLowerCase().contains(event.text.toLowerCase()) ? temp.add(element) : null;
    }
    emit(state.copyWith(searchList: temp, isSearch: true));
  }

  Future<void> _setStreamListEvent(SetStreamListEvent event, Emitter<ShowAccountsListState> emit) async {
    if (streamController != null) {
      await streamController!.cancel();
    }
    streamController = _getAccountList().listen((event) {
      list = event.data;
      add(const OnGetShowAccountsListEvent());
    });
  }
}
