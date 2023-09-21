import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  const HomeState({required this.isLoading, required this.email, required this.name});

  const HomeState.initialState()
      : this(
          isLoading: true,
          email: "",
          name: "",
        );

  final bool isLoading;
  final String email;
  final String name;

  HomeState copyWith({
    bool? isLoading,
    String? email,
    String? name,
  }) =>
      HomeState(
        isLoading: isLoading ?? this.isLoading,
        email: email ?? this.email,
        name: name ?? this.name,
      );

  @override
  List<Object?> get props => [email];
}
