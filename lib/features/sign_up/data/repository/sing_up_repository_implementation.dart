import 'package:password/core/response/response.dart';
import 'package:password/core/utiles/typedef.dart';
import 'package:password/features/sign_up/data/data_source/sign_up_data_source.dart';
import 'package:password/features/sign_up/data/data_source/sign_up_local_source.dart';
import 'package:password/features/sign_up/data/models/SingUpDetailsModel.dart';
import 'package:password/features/sign_up/domain/entities/sign_up.dart';
import 'package:password/features/sign_up/domain/repository/sign_up_repo.dart';

class SignUpRepositoryImplementation extends SignUpRepository {
  const SignUpRepositoryImplementation({required SignUpDataSource signUpDataSource, required SignUpLocalSource signUpLocalSource})
      : _signUpDataSource = signUpDataSource,
        _signUpLocalSource = signUpLocalSource;

  final SignUpDataSource _signUpDataSource;
  final SignUpLocalSource _signUpLocalSource;

  @override
  FutureResponse singUp({required SignUpDetails user}) async {
    final params = SignUpDetailsModel(
      email: user.email,
      name: user.name,
      phone: user.phone,
      password: user.password,
    );

    try {
      final String result = await _signUpDataSource.singUp(params);
      if(result.isEmpty) throw Exception();
      await _signUpLocalSource.saveToken(result);
      await _signUpLocalSource.saveUserDetails(params);
      await _signUpDataSource.saveUser(params, result);
      return SuccessResponse(result);
    } catch (e) {
      return FailureResponse(e.toString());
    }
  }
}
