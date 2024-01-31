import 'package:equatable/equatable.dart';
import 'package:password/features/show_accounts_list/domain/entities/show_account.dart';

class ShowAccountsListState extends Equatable {
  const ShowAccountsListState({
    required this.isLoading,
    required this.list,
    required this.state,
    required this.searchList,
    required this.isSearch,
  });

  const ShowAccountsListState.initialState() : this(isLoading: false, list: const [], state: false, searchList: const [], isSearch: false);

  final bool isLoading;
  final List<ShowAccount> list, searchList;
  final bool state;
  final bool isSearch;

  ShowAccountsListState copyWith({
    bool? isLoading,
    List<ShowAccount>? list,
    List<ShowAccount>? searchList,
    bool? state,
    bool? isSearch,
  }) =>
      ShowAccountsListState(
        isLoading: isLoading ?? this.isLoading,
        list: list ?? this.list,
        state: state ?? this.state,
        searchList: searchList ?? this.searchList,
        isSearch: isSearch ?? this.isSearch,
      );

  @override
  List<Object?> get props => [list, isLoading, searchList, isSearch];
}
