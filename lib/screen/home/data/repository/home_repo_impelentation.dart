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
  FutureResponse getUserData() async {
    try {
      final result = _homeDataSource.getUserData();
      return SuccessResponse<UsersModel>(result);
    } catch (e) {
      return FailureResponse(e.toString());
    }
  }

}
