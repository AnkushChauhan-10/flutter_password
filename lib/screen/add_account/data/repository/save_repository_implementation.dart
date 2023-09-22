import 'package:password/core/response/response.dart';
import 'package:password/core/utiles/network_connectivity.dart';
import 'package:password/core/utiles/typedef.dart';
import 'package:password/features/save_data/data/data_source/save_data_offline_repo.dart';
import 'package:password/features/save_data/data/data_source/save_data_source_repo.dart';
import 'package:password/features/save_data/data/model/account_model.dart';
import 'package:password/features/save_data/domain/entities/account.dart';
import 'package:password/features/save_data/domain/repository/save_repo.dart';

class SaveRepoImplementation extends SaveRepository {
  final SaveDataSourceRepo _remoteRepo;
  final SaveDataOfflineRepo _offlineRepo;
  final NetworkConnectivity _networkConnectivity;

  SaveRepoImplementation({
    required SaveDataSourceRepo saveDataSourceRepo,
    required SaveDataOfflineRepo saveDataOfflineRepo,
    required NetworkConnectivity networkConnectivity,
  })  : _remoteRepo = saveDataSourceRepo,
        _networkConnectivity = networkConnectivity,
        _offlineRepo = saveDataOfflineRepo;

  @override
  FutureResponse saveData({required Account account}) async {
    dynamic result;
    try {
      if (await _networkConnectivity.isConnected()) {
        AccountModel model = AccountModel(
          email: account.email,
          title: account.title,
          websiteURL: account.websiteURL,
          userName: account.userName,
          password: account.password,
          lastUpdate: account.lastUpdate,
          isUpdate: true,
        );
        var path = _offlineRepo.getToken();
        result = await _remoteRepo.saveData(path, model.toMap());
        var date = int.parse(account.lastUpdate);
        await _remoteRepo.lastUpdate(date, path);
      }
      AccountModel model = AccountModel(
        email: account.email,
        title: account.title,
        websiteURL: account.websiteURL,
        userName: account.userName,
        password: account.password,
        lastUpdate: account.lastUpdate,
        isUpdate: result == null ? false : true,
      );
      await _offlineRepo.saveData(model);
      var date = int.parse(account.lastUpdate);
      _offlineRepo.lastUpdate(date);
      return SuccessResponse<dynamic>(result);
    } catch (e) {
      return FailureResponse(e.toString());
    }
  }
}
