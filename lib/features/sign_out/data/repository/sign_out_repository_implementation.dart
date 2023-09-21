import 'package:password/core/response/response.dart';
import 'package:password/core/utiles/typedef.dart';
import 'package:password/features/sign_out/data/data_source/local_sign_out_data_source.dart';
import 'package:password/features/sign_out/domain/repository/sign_out_repository.dart';

class SignOutRepositoryImplementation extends SignOutRepository {
  const SignOutRepositoryImplementation({required LocalSignOutDataSource localSignOutDataSource}) : _localSignOutDataSource = localSignOutDataSource;

  final LocalSignOutDataSource _localSignOutDataSource;

  @override
  FutureResponse signOut() async {
    try {
      final result = await _localSignOutDataSource.signOutLocal();
      return SuccessResponse(result);
    } catch (e) {
      return FailureResponse(e);
    }
  }
}
