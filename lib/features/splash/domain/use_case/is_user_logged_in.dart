import 'package:password/core/use_case/use_case_with_out_params.dart';
import 'package:password/features/splash/domain/repository/splash_repository.dart';

class IsUserLoggedIn extends UseCaseWithOutParams<bool> {
  IsUserLoggedIn({required SplashRepository splashRepository}) : _splashRepository = splashRepository;

  final SplashRepository _splashRepository;

  @override
  bool call() => _splashRepository.isUserLoggedIn();
}
