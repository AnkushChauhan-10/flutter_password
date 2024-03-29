import 'package:password/core/model/users.dart';
import 'package:password/core/response/response.dart';
import 'package:password/core/utiles/network_connectivity.dart';
import 'package:password/core/utiles/typedef.dart';
import 'package:password/screen/sign_in/data/data_source/sign_in_data_source.dart';
import 'package:password/screen/sign_in/data/data_source/sign_in_local_source.dart';
import 'package:password/screen/sign_in/data/models/sign_in_details_model.dart';
import 'package:password/screen/sign_in/domain/entities/sign_in_details.dart';
import 'package:password/screen/sign_in/domain/repository/sign_in_repository.dart';

class SignInRepositoryImplementation extends SignInRepository {
  const SignInRepositoryImplementation({
    required SignInDataSource signInDataSource,
    required SignInLocalSource signInLocalSource,
    required NetworkConnectivity networkConnectivity,
  })  : _signInDataSource = signInDataSource,
        _signInLocalSource = signInLocalSource,
        _networkConnectivity = networkConnectivity;

  final SignInLocalSource _signInLocalSource;
  final SignInDataSource _signInDataSource;
  final NetworkConnectivity _networkConnectivity;

  @override
  FutureResponse sigIn({required SignInDetails user}) async {
    final params = SignInDetailsModel(
      email: user.email,
      password: user.password,
    );

    try {
      await _networkConnectivity.isConnected() ? null : throw Exception("No internet connection\nTry again!");
      final String result = await _signInDataSource.singIn(params);
      if (result.isEmpty) throw Exception();
      await _signInLocalSource.saveToken(result);
      DataMap user = await _signInDataSource.getUser(result);
      UsersModel usersModel = UsersModel.fromMap(user);
      final setUp = await _signInLocalSource.saveUserDetails(usersModel.toMap());
      // if(!setUp) throw Exception("Db error");
      return SuccessResponse(result);
    } catch (e) {
      return FailureResponse(e.toString());
    }
  }
}
