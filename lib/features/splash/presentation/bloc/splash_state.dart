import 'package:equatable/equatable.dart';

class SplashState extends Equatable {
  const SplashState({required this.retrievedUser, required this.completeSplash, required this.nextPage});

  const SplashState.initState()
      : this(
          retrievedUser: false,
          completeSplash: false,
          nextPage: "",
        );

  final bool retrievedUser;
  final bool completeSplash;
  final String nextPage;

  SplashState copyWith({bool? retrievedUser, bool? completeSplash, String? nextPage}) => SplashState(
        retrievedUser: retrievedUser ?? this.retrievedUser,
        completeSplash: completeSplash ?? this.completeSplash,
        nextPage: nextPage ?? this.nextPage,
      );

  @override
  List<Object?> get props => [];
}
