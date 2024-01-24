import 'package:password/core/response/response.dart';
import 'package:password/core/utiles/network_connectivity.dart';
import 'package:password/core/utiles/typedef.dart';
import 'package:password/screen/account/data/data_source/save_data_offline_repo.dart';
import 'package:password/screen/account/data/data_source/save_data_source_repo.dart';
import 'package:password/screen/account/domain/repository/save_repo.dart';
import 'package:password/screen/save_data/data/model/account_model.dart';
import 'package:password/screen/save_data/domain/entities/account.dart';

class EditRepoImplementation extends EditRepository {
  final EditDataSourceRepo _remoteRepo;
  final EditDataOfflineRepo _offlineRepo;
  final NetworkConnectivity _networkConnectivity;

  EditRepoImplementation({
    required EditDataSourceRepo editDataSourceRepo,
    required EditDataOfflineRepo editDataOfflineRepo,
    required NetworkConnectivity networkConnectivity,
  })  : _remoteRepo = editDataSourceRepo,
        _networkConnectivity = networkConnectivity,
        _offlineRepo = editDataOfflineRepo;

  @override
  FutureResponse editData({required Account account}) async {
    dynamic result;
    try {
      if (await _networkConnectivity.isConnected()) {
        AccountModel model = AccountModel(
          title: account.title,
          password: account.password,
          lastUpdate: account.lastUpdate,
          userId: account.userId,
        );
        var path = _offlineRepo.getToken();
        result = await _remoteRepo.editData(path, model.toMap());
        var date = account.lastUpdate;
        await _remoteRepo.lastUpdate(date, path);
      } else {
        throw Exception("No internet connection");
      }
      AccountModel model = AccountModel(
        title: account.title,
        userId: account.userId,
        password: account.password,
        lastUpdate: account.lastUpdate,
      );
      await _offlineRepo.editData(model);
      var date = account.lastUpdate;
      _offlineRepo.lastUpdate(date);
      return SuccessResponse<dynamic>(result);
    } catch (e) {
      return FailureResponse(e.toString());
    }
  }
}
