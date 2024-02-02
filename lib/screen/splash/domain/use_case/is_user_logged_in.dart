import 'package:password/core/use_case/use_case_with_out_params.dart';
import 'package:password/screen/splash/domain/repository/splash_repository.dart';

class IsUserLoggedIn extends UseCaseWithOutParams<bool> {
  IsUserLoggedIn({required SplashRepository splashRepository}) : _splashRepository = splashRepository;

  final SplashRepository _splashRepository;

  @override
  bool call() => _splashRepository.isUserLoggedIn();
}

class IsLockSet extends UseCaseWithOutParams<bool> {
  IsLockSet({required SplashRepository splashRepository}) : _splashRepository = splashRepository;

  final SplashRepository _splashRepository;

  @override
  bool call() => _splashRepository.isLockSet();
}
