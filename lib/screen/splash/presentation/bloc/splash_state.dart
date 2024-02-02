import 'package:equatable/equatable.dart';

class SplashState extends Equatable {
  const SplashState({
    required this.retrievedUser,
    required this.completeSplash,
    required this.nextPage,
    required this.isLock,
  });

  const SplashState.initState()
      : this(
          retrievedUser: false,
          completeSplash: false,
          nextPage: "",
          isLock: false,
        );

  final bool retrievedUser;
  final bool completeSplash;
  final bool isLock;
  final String nextPage;

  SplashState copyWith({bool? retrievedUser, bool? completeSplash, String? nextPage, bool? isLock}) => SplashState(
        retrievedUser: retrievedUser ?? this.retrievedUser,
        completeSplash: completeSplash ?? this.completeSplash,
        nextPage: nextPage ?? this.nextPage,
        isLock: isLock ?? this.isLock,
      );

  @override
  List<Object?> get props => [];
}
