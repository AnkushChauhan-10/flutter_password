import 'package:password/core/response/response.dart';
import 'package:password/core/utiles/network_connectivity.dart';
import 'package:password/core/utiles/typedef.dart';
import 'package:password/features/delete/data/data_source/local_delete_data_source.dart';
import 'package:password/features/delete/data/data_source/remote_delete_data_source.dart';
import 'package:password/features/delete/domain/repository/delete_repository.dart';

class DeleteRepositoryImplementation extends DeleteRepository {
  DeleteRepositoryImplementation({
    required RemoteDeleteDataSource remoteDeleteDataSource,
    required LocalDeleteDataSource localDeleteDataSource,
    required NetworkConnectivity networkConnectivity
  })
      : _remoteDeleteDataSource = remoteDeleteDataSource,
        _localDeleteDataSource = localDeleteDataSource,
        _networkConnectivity = networkConnectivity;

  final RemoteDeleteDataSource _remoteDeleteDataSource;
  final LocalDeleteDataSource _localDeleteDataSource;
  final NetworkConnectivity _networkConnectivity;

  @override
  FutureResponse delete(DataMap dataMap) async {
    bool remoteDelete = false , localDelete = false;
    try {
      var connection = await _networkConnectivity.isConnected();
      if(connection){
        var path = _localDeleteDataSource.getToken();
        remoteDelete = await _remoteDeleteDataSource.deleteData(dataMap['title'], path);
      }
      localDelete = await _localDeleteDataSource.deleteData(dataMap);
      return SuccessResponse(localDelete);
    } catch (e) {
      return FailureResponse(e);
    }
  }
}
