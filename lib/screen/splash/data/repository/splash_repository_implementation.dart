import 'package:password/screen/splash/data/data_source/splash_local_data_source.dart';
import 'package:password/screen/splash/domain/repository/splash_repository.dart';

class SplashRepositoryImplementation extends SplashRepository {
  SplashRepositoryImplementation({required SplashLocalDataSource splashLocalDataSource}) : _splashLocalDataSource = splashLocalDataSource;

  final SplashLocalDataSource _splashLocalDataSource;

  @override
  bool isUserLoggedIn() {
    try {
      String? result = _splashLocalDataSource.getUserLoggedInData();
      if (result == null) return false;
      if (result.isEmpty) return false;
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  bool isLockSet() {
    try {
      String? result = _splashLocalDataSource.lock();
      if (result == null) return false;
      if (result.isEmpty) return false;
      return true;
    } catch (e) {
      return false;
    }
  }
}
