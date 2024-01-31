import 'dart:async';

import 'package:password/core/response/response.dart';
import 'package:password/core/utiles/network_connectivity.dart';
import 'package:password/core/utiles/typedef.dart';
import 'package:password/features/show_accounts_list/data/data_source/show_account_list_local_data_source.dart';
import 'package:password/features/show_accounts_list/data/data_source/show_account_list_remote_data_source.dart';
import 'package:password/features/show_accounts_list/data/models/show_account_model.dart';
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
  final StreamController<Response> streamController = StreamController();

  @override
  Stream<Response> getAccountsList() {
    List<DataMap> map;
    // StreamSubscription<List<DataMap>> onlineStream = _getDataOnline().listen((event) {
    //   final data = List.generate(event.length, (index) => ShowAccountModel.fromMap(event[index]));
    //   fetchData(event);
    //   streamController.add(SuccessResponse(data));
    // });
    // print("-------------------------------------------------SliverAccountList Repo ------------------------------- ");
    // init(onlineStream);
    // _networkConnectivity.isChange().listen(
    //   (event) async {
    //     try {
    //       if (event) {
    //         onlineStream.resume();
    //       } else {
    //         onlineStream.pause();
    //         // map = await _getDataOffline();
    //         // streamController.add(SuccessResponse(List.generate(map.length, (index) => ShowAccountModel.fromMap(map[index]))));
    //       }
    //     } catch (e) {}
    //   },
    // );

    return _showAccountsListLocalDataSource.getAccountList().map(
          (event) => SuccessResponse(
            List.generate(
              event.length,
              (index) => ShowAccountModel.fromMap(
                event[index],
              ),
            ),
          ),
        );
  }

  Stream<List<DataMap>> _getDataOnline() {
    final path = _showAccountsListLocalDataSource.getToken();
    final result = _showAccountsListRemoteDataSource.getAccountList(path);
    return result;
  }

  // Future<List<DataMap>> _getDataOffline() async {
  //   final result = await _showAccountsListLocalDataSource.getAccountList();
  //   return result;
  // }

  Future<void> fetchData(List<DataMap> data) async {
    int lastUpdate = _showAccountsListLocalDataSource.getLastUpdate();
    data.forEach((element) {
      int update = element["last_update"].toInt() ?? 0;
      update > lastUpdate ? _showAccountsListLocalDataSource.saveData(element) : null;
    });
    final path = _showAccountsListLocalDataSource.getToken();
    // final num update = await _showAccountsListRemoteDataSource.getLastUpdate(path);
    // _showAccountsListLocalDataSource.lastUpdate(update.toInt());
  }

  Future<void> init(StreamSubscription<List<DataMap>> stream) async {
    if (await _networkConnectivity.isConnected()) {
      stream.resume();
    } else {
      stream.pause();
      // List<DataMap> map = await _getDataOffline();
      // streamController.add(SuccessResponse(List.generate(map.length, (index) => ShowAccountModel.fromMap(map[index]))));
    }
  }
}
