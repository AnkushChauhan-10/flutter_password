import 'package:password/core/response/response.dart';
import 'package:password/core/utiles/network_connectivity.dart';
import 'package:password/core/utiles/typedef.dart';
import 'package:password/screen/update_account/data/data_source/update_local_data_source.dart';
import 'package:password/screen/update_account/data/data_source/update_remote_data_source.dart';
import 'package:password/screen/update_account/data/model/update_account_model.dart';
import 'package:password/screen/update_account/domain/entities/update_account.dart';
import 'package:password/screen/update_account/domain/repository/update_repository.dart';

class UpdateRepositoryImplementation extends UpdateRepository {
  const UpdateRepositoryImplementation({
    required UpdateRemoteDataSource updateRemoteDataSource,
    required UpdateLocalDataSource updateLocalDataSource,
    required NetworkConnectivity networkConnectivity,
  })
      : _updateRemoteDataSource = updateRemoteDataSource,
        _networkConnectivity = networkConnectivity,
        _updateLocalDataSource = updateLocalDataSource;

  final UpdateLocalDataSource _updateLocalDataSource;
  final UpdateRemoteDataSource _updateRemoteDataSource;
  final NetworkConnectivity _networkConnectivity;

  @override
  FutureResponse update(UpdateAccount account) async {
    UpdateAccountModel accountModel = UpdateAccountModel(
      userName: account.userName,
      password: account.password,
      lastUpdate: account.lastUpdate,
      isUpdate: account.isUpdate,
      title: account.title,
      websiteURL: account.websiteURL,
      email: account.email,);
    try {
      if (await _networkConnectivity.isConnected()) {
        var token = _updateLocalDataSource.getToken();
        await _updateRemoteDataSource.update(accountModel.toMap(),token);
      }
      await _updateLocalDataSource.update(accountModel.toMap());
      return const SuccessResponse(true);
    }catch(e){
      return FailureResponse(e.toString());
    }
  }
}
