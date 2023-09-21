import 'package:password/core/response/response.dart';
import 'package:password/core/utiles/typedef.dart';
import 'package:password/screen/sign_in/data/data_source/sign_in_data_source.dart';
import 'package:password/screen/sign_in/data/data_source/sign_in_local_source.dart';
import 'package:password/screen/sign_in/data/models/sign_in_details_model.dart';
import 'package:password/screen/sign_in/domain/entities/sign_in_details.dart';
import 'package:password/screen/sign_in/domain/repository/sign_in_repository.dart';

class SignInRepositoryImplementation extends SignInRepository {
  const SignInRepositoryImplementation({required SignInDataSource signInDataSource, required SignInLocalSource signInLocalSource})
      : _signInDataSource = signInDataSource,
        _signInLocalSource = signInLocalSource;

  final SignInLocalSource _signInLocalSource;
  final SignInDataSource _signInDataSource;

  @override
  FutureResponse sigIn({required SignInDetails user}) async {
    final params = SignInDetailsModel(
      email: user.email,
      password: user.password,
    );

    try {
      final String result = await _signInDataSource.singIn(params);
      if (result.isEmpty) throw Exception();
      await _signInLocalSource.saveToken(result);
      List<String> user = await _signInDataSource.getUser(result);
      await _signInLocalSource.saveUserDetails(user);
      return SuccessResponse(result);
    } catch (e) {
      return FailureResponse(e.toString());
    }
  }
}
