import 'package:password/core/response/response.dart';
import 'package:password/core/utiles/network_connectivity.dart';
import 'package:password/core/utiles/typedef.dart';
import 'package:password/features/fetch_db/data/data_source/fetch_data_offline_source.dart';
import 'package:password/features/fetch_db/data/data_source/fetch_data_online_source.dart';
import 'package:password/features/fetch_db/domain/repository/fetch_data_repository.dart';

class FetchDataRepoImplementation extends FetchDataRepository {
  const FetchDataRepoImplementation({
    required FetchDataOfflineRepo fetchDataOfflineRepo,
    required FetchDataOnlineSource onlineSource,
    required NetworkConnectivity connectivity,
  })  : _onlineSource = onlineSource,
        _dataOfflineRepo = fetchDataOfflineRepo,
        _connectivity = connectivity;

  final FetchDataOfflineRepo _dataOfflineRepo;
  final FetchDataOnlineSource _onlineSource;
  final NetworkConnectivity _connectivity;

  @override
  FutureResponse fetchData() async {
    try {
      if (!await _connectivity.isConnected()) throw Exception();
      final path = _dataOfflineRepo.getToken();
      final lastUpdate = _dataOfflineRepo.getLastUpdate();
      final online = await _onlineSource.getData(path, lastUpdate);
      online.forEach((element) async => await _dataOfflineRepo.saveData(element));
      int last = (await _onlineSource.getLastUpdate(path)).toInt();
      _dataOfflineRepo.lastUpdate(last);
      return const SuccessResponse<bool>(true);
    } catch (e) {
      return FailureResponse(e.toString());
    }
  }
}
