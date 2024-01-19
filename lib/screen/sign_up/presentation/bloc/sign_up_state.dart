import 'package:equatable/equatable.dart';

class SignUpState extends Equatable {
  const SignUpState({
    required this.isLoading,
    required this.name,
    required this.phone,
    required this.password,
    required this.email,
    required this.error,
  });

  const SignUpState.initState()
      : this(
          isLoading: false,
          name: "",
          password: "",
          phone: "",
          email: "",
          error: null,
        );

  final bool isLoading;
  final String name;
  final String email;
  final String password;
  final String phone;
  final String? error;

  SignUpState copyWith({
    String? name,
    String? email,
    String? password,
    String? phone,
    bool? isLoading,
    String? error,
  }) =>
      SignUpState(
        isLoading: isLoading ?? this.isLoading,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        password: password ?? this.password,
        email: email ?? this.email,
        error: error ?? this.error,
      );

  @override
  List<Object?> get props => [email, phone, error];
}
