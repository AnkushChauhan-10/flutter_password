import 'package:password/core/response/response.dart';
import 'package:password/core/utiles/network_connectivity.dart';
import 'package:password/core/utiles/typedef.dart';
import 'package:password/features/show_accounts_list/data/data_source/show_account_list_local_data_source.dart';
import 'package:password/features/show_accounts_list/data/data_source/show_account_list_remote_data_source.dart';
import 'package:password/features/show_accounts_list/data/models/show_account_model.dart';
import 'package:password/features/show_accounts_list/domain/entities/show_account.dart';
import 'package:password/features/show_accounts_list/domain/repository/show_accounts_list_repository.dart';

class ShowAccountsListRepositoryImplementation extends ShowAccountsListRepository {
  ShowAccountsListRepositoryImplementation({
    required ShowAccountsListRemoteDataSource showAccountsListRemoteDataSource,
    required ShowAccountsListLocalDataSource showAccountsListLocalDataSource,
    required NetworkConnectivity networkConnectivity,
  })  : _showAccountsListRemoteDataSource = showAccountsListRemoteDataSource,
        _showAccountsListLocalDataSource = showAccountsListLocalDataSource,
        _networkConnectivity = networkConnectivity;

  final ShowAccountsListRemoteDataSource _showAccountsListRemoteDataSource;
  final ShowAccountsListLocalDataSource _showAccountsListLocalDataSource;
  final NetworkConnectivity _networkConnectivity;

  @override
  FutureResponse getAccountsList() async {
    List<DataMap> map;
    try{
      // if (await _networkConnectivity.isConnected()) {
      //   map = await _getDataOnline();
      // } else {
      //   map = await _getDataOffline();
      // }
      map = await _getDataOffline();
      print(map);
      return SuccessResponse<List<ShowAccount>>(
        List.generate(
          map.length,
              (index) => ShowAccountModel.fromMap(map[index]),
        ),
      );
    }catch (e){
      return FailureResponse(e.toString());
    }
  }

  Future<List<DataMap>> _getDataOnline() async {
    final path = _showAccountsListLocalDataSource.getToken();
    final result = await _showAccountsListRemoteDataSource.getAccountList(path);
    return result;
  }

  Future<List<DataMap>> _getDataOffline() async {
    final result = await _showAccountsListLocalDataSource.getAccountList();
    return result;
  }
}
