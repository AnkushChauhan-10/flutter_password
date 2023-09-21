import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:password/core/response/response.dart';
import 'package:password/core/utiles/network_connectivity.dart';
import 'package:password/core/utiles/typedef.dart';
import 'package:password/features/save_data/data/data_source/save_data_offline_repo.dart';
import 'package:password/features/save_data/data/data_source/save_data_source_repo.dart';
import 'package:password/features/save_data/data/repository/save_repository_implementation.dart';
import 'package:password/features/save_data/domain/entities/account.dart';

class MockSaveDataSourceRepo extends Mock implements SaveDataSourceRepo {}

class MockSaveDataOfflineRepo extends Mock implements SaveDataOfflineRepo {}

void main() {
  late SaveDataSourceRepo repo;
  late SaveDataOfflineRepo offlineRepo;
  late SaveRepoImplementation implementation;

  setUpAll(() {
    repo = MockSaveDataSourceRepo();
    offlineRepo = MockSaveDataOfflineRepo();
    implementation = SaveRepoImplementation(saveDataSourceRepo: repo,saveDataOfflineRepo: offlineRepo, networkConnectivity: const NetworkConnectivity());
  });

  DataMap demoMap = {};
  Account demoAccount = const Account.empty();
  test('should return Response', () async {
    when(() => repo.saveData("",demoMap)).thenAnswer((_) async => null);
    final result = await implementation.saveData(account: demoAccount);
    expect(result, equals(const SuccessResponse<dynamic>(null)));
    // verify(()=>repo.saveData(demoMap)).called(1);
    // verifyNoMoreInteractions(repo);
  });
}
