import 'package:equatable/equatable.dart';
import 'package:password/features/show_accounts_list/domain/entities/show_account.dart';

class ShowAccountsListState extends Equatable {
  const ShowAccountsListState({
    required this.isLoading,
    required this.list,
    required this.state,
  });

  const ShowAccountsListState.initialState()
      : this(
          isLoading: true,
          list: const [],
          state: false,
        );

  final bool isLoading;
  final List<ShowAccount> list;
  final bool state;

  ShowAccountsListState copyWith({
    bool? isLoading,
    List<ShowAccount>? list,
    bool? state,
  }) =>
      ShowAccountsListState(
        isLoading: isLoading ?? this.isLoading,
        list: list ?? this.list,
        state: state ?? this.state,
      );

  @override
  List<Object?> get props => [list,isLoading];
}
