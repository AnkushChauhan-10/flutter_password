import 'package:equatable/equatable.dart';
import 'package:password/screen/home/domain/entities/account_data.dart';

class HomeState extends Equatable {
  const HomeState({required this.isLoading, required this.list, required this.email, required this.name});

  const HomeState.initialState()
      : this(
          isLoading: true,
          list: const [],
          email: "",
          name: "",
        );

  final bool isLoading;
  final List<AccountData> list;
  final String email;
  final String name;

  HomeState copyWith({
    bool? isLoading,
    List<AccountData>? list,
    String? email,
    String? name,
  }) =>
      HomeState(
        isLoading: isLoading ?? this.isLoading,
        list: list ?? this.list,
        email: email ?? this.email,
        name: name ?? this.name,
      );

  @override
  List<Object?> get props => [list];
}
