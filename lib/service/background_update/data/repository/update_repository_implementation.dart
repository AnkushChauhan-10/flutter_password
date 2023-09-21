import 'package:password/core/response/response.dart';
import 'package:password/core/utiles/typedef.dart';
import 'package:password/service/background_update/data/data_source/local_update_data_source.dart';
import 'package:password/service/background_update/data/data_source/remote_update_data_source.dart';
import 'package:password/service/background_update/domain/repository/update_repository.dart';

class UpdateRepositoryImplementation extends UpdateRepository {
  UpdateRepositoryImplementation({
    required RemoteUpdateDataSource remoteDataSource,
    required LocalUpdateDataSource localDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  final RemoteUpdateDataSource _remoteDataSource;
  final LocalUpdateDataSource _localDataSource;

  @override
  FutureResponse update() async {
    var path = _localDataSource.getToken();

    int firebase = await _remoteDataSource.getLastUpdate(path);
    int local = await _localDataSource.getLastUpdate();

    try {
      if (firebase > local) {
        final remoteDataMap = await _remoteDataSource.getAccountList(path, local);
        final result = await _localDataSource.upDateTable(remoteDataMap);
        return const SuccessResponse("update");
      } else if (firebase < local) {
        final localDataMap = await _localDataSource.getAccountList();
        final map = List.generate(localDataMap.length, (index) => localDataMap[index].copyWith(isUpdate: true).toMap());
        final result = await _remoteDataSource.updateFireBase(map, path);
        await _localDataSource.upDateTable(map);
        return const SuccessResponse("update");
      }
      return const SuccessResponse("Up To Date");
    } catch (e) {
      return FailureResponse(e.toString());
    }
  }
}
