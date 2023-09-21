import 'package:password/core/model/users.dart';
import 'package:password/core/response/response.dart';
import 'package:password/core/utiles/network_connectivity.dart';
import 'package:password/core/utiles/typedef.dart';
import 'package:password/features/home/data/data_source/home_data_source.dart';
import 'package:password/features/home/data/data_source/home_remote_data_source.dart';
import 'package:password/features/home/data/models/account_data_model.dart';
import 'package:password/features/home/domain/entities/account_data.dart';
import 'package:password/features/home/domain/repository/home_repo.dart';

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
  FutureResponse getAccountsList() async {
    if (await _networkConnectivity.isConnected()) {
      return await _getDataOnline();
    }
    return await _getDataOffline();
  }

  FutureResponse _getDataOnline() async {
    try {
      final path = _homeDataSource.getToken();
      final result = await _remoteDataSource.getAccountList(path);
      return SuccessResponse<List<AccountData>>(result);
    } catch (e) {
      return FailureResponse(e.toString());
    }
  }

  FutureResponse _getDataOffline() async {
    try {
      final result = await _homeDataSource.getAccountList();
      return SuccessResponse<List<AccountData>>(
        List.generate(
          result.length,
          (index) => AccountDataModel.fromMap(result[index]),
        ),
      );
    } catch (e) {
      return FailureResponse(e.toString());
    }
  }

  @override
  FutureResponse getUserData() async {
    try {
      final result = _homeDataSource.getUserData();
      return SuccessResponse<UsersModel>(result);
    } catch (e) {
      return FailureResponse(e.toString());
    }
  }

  @override
  FutureResponse signOut() async {
    try {
      final result = await _homeDataSource.signOut();
      return SuccessResponse(result);
    } catch (e) {
      return FailureResponse(e.toString());
    }
  }

  @override
  FutureResponse deleteAccount(String siteName) async {
    var result;
    try {
      if (await _networkConnectivity.isConnected()) {
        var path = _homeDataSource.getToken();
        await _remoteDataSource.deleteAccount(path, siteName);
      }
      result = await _homeDataSource.deleteAccount(siteName);
      return SuccessResponse(result);
    } catch (e) {
      return FailureResponse(e.toString());
    }
  }
}
