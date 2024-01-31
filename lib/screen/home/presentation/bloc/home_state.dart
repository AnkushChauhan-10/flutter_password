import 'package:equatable/equatable.dart';
import 'package:password/core/model/users.dart';

class HomeState extends Equatable {
  const HomeState({
    required this.isLoading,
    required this.users,
    required this.loggedUser,
    required this.accounts,
  });

  const HomeState.initialState()
      : this(
          isLoading: true,
          users: const [],
          accounts: const [],
          loggedUser: const UsersModel.empty(),
        );

  final bool isLoading;
  final List<UsersModel> users;
  final List<UsersModel> accounts;
  final UsersModel loggedUser;

  HomeState copyWith({
    bool? isLoading,
    List<UsersModel>? users,
    List<UsersModel>? accounts,
    UsersModel? loggedUser,
  }) =>
      HomeState(
        isLoading: isLoading ?? this.isLoading,
        users: users ?? this.users,
        loggedUser: loggedUser ?? this.loggedUser,
        accounts: accounts ?? this.accounts,
      );

  @override
  List<Object?> get props => [isLoading];
}
