import 'dart:async';

import 'package:password/core/response/response.dart';
import 'package:password/core/utiles/network_connectivity.dart';
import 'package:password/core/utiles/typedef.dart';
import 'package:password/features/fetch_db/data/data_source/fetch_data_offline_source.dart';
import 'package:password/features/fetch_db/data/data_source/fetch_data_online_source.dart';
import 'package:password/features/fetch_db/domain/repository/fetch_info_repository.dart';

class FetchInfoRepoImplementation extends FetchInfoRepository {
  const FetchInfoRepoImplementation({
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
  FutureResponse fetchInfo() async {
    StreamController stream = StreamController<bool>();
    try {
      if (!await _connectivity.isConnected()) throw Exception();
      final path = _dataOfflineRepo.getToken();
      final lastUpdate = _dataOfflineRepo.getLastUpdate();
      _onlineSource.lastUpdate(path).listen((event) {
        dynamic last = event["last_update"];
        last = last.toInt();
        stream.add(lastUpdate < last);
      });
      return SuccessResponse(stream.stream);
    } catch (e) {
      return FailureResponse(e.toString());
    }
  }
}
