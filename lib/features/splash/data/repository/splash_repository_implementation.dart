import 'package:password/features/splash/data/data_source/splash_local_data_source.dart';
import 'package:password/features/splash/domain/repository/splash_repository.dart';

class SplashRepositoryImplementation extends SplashRepository {
  SplashRepositoryImplementation({required SplashLocalDataSource splashLocalDataSource}) : _splashLocalDataSource = splashLocalDataSource;

  final SplashLocalDataSource _splashLocalDataSource;

  @override
  bool isUserLoggedIn() {
    try{
      String? result = _splashLocalDataSource.getUserLoggedInData();
      if(result == null) return false;
      if(result.isEmpty) return false;
      return true;
    }catch(e){
      return false;
    }
  }
}
