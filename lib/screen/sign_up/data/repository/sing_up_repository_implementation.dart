import 'package:password/core/response/response.dart';
import 'package:password/core/utiles/network_connectivity.dart';
import 'package:password/core/utiles/typedef.dart';
import 'package:password/screen/sign_up/data/data_source/sign_up_data_source.dart';
import 'package:password/screen/sign_up/data/data_source/sign_up_local_source.dart';
import 'package:password/screen/sign_up/data/models/SingUpDetailsModel.dart';
import 'package:password/screen/sign_up/domain/entities/sign_up.dart';
import 'package:password/screen/sign_up/domain/repository/sign_up_repo.dart';

class SignUpRepositoryImplementation extends SignUpRepository {
  const SignUpRepositoryImplementation({
    required SignUpDataSource signUpDataSource,
    required SignUpLocalSource signUpLocalSource,
    required NetworkConnectivity networkConnectivity,
  })  : _signUpDataSource = signUpDataSource,
        _signUpLocalSource = signUpLocalSource,
        _networkConnectivity = networkConnectivity;

  final SignUpDataSource _signUpDataSource;
  final SignUpLocalSource _signUpLocalSource;
  final NetworkConnectivity _networkConnectivity;

  @override
  FutureResponse singUp({required SignUpDetails user}) async {
    final params = SignUpDetailsModel(
      email: user.email,
      name: user.name,
      password: user.password,
    );

    try {
      await _networkConnectivity.isConnected() ? null : throw Exception("No internet connection\nTry again!");
      final String result = await _signUpDataSource.singUp(params);
      if (result.isEmpty) throw Exception();
      await _signUpLocalSource.saveToken(result);
      await _signUpDataSource.saveUser(params, result);
      await _signUpLocalSource.saveUserDetails(params, result);
      return SuccessResponse(result);
    } catch (e) {
      return FailureResponse(e.toString());
    }
  }
}
