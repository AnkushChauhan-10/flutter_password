import 'package:password/core/model/users.dart';
import 'package:password/core/response/response.dart';
import 'package:password/core/utiles/network_connectivity.dart';
import 'package:password/core/utiles/typedef.dart';
import 'package:password/screen/home/data/data_source/home_data_source.dart';
import 'package:password/screen/home/data/data_source/home_remote_data_source.dart';
import 'package:password/screen/home/domain/repository/home_repo.dart';

class HomeRepoImplementation extends HomeRepository {
  HomeRepoImplementation({
    required HomeRemoteDataSource homeRemoteDataSource,
    required HomeDataSource homeDataSource,
    required NetworkConnectivity networkConnectivity,
  })  : _remoteDataSource = homeRemoteDataSource,
        _homeDataSource = homeDataSource,
        _networkConnectivity = networkConnectivity;

  final HomeRemoteDataSource _remoteDataSource;
  final HomeDataSource _homeDataSource;
  final NetworkConnectivity _networkConnectivity;

  @override
  FutureResponse getUsers() async {
    try {
      final result = await _homeDataSource.getUsers();
      return SuccessResponse<List<UsersModel>>(List.generate(result.length, (index) => UsersModel.fromMap(result[index])));
    } catch (e) {
      return FailureResponse(e.toString());
    }
  }

  @override
  FutureResponse loggedUser() async {
    try {
      final result = _homeDataSource.getToken();
      return SuccessResponse<String>(result);
    } catch (e) {
      return FailureResponse(e.toString());
    }
  }

  @override
  FutureResponse changeUser(String token) async {
    try {
      final result = await _homeDataSource.setToken(token);
      return SuccessResponse<bool>(result);
    } catch (e) {
      return FailureResponse(e.toString());
    }
  }
}
