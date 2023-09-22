import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:password/core/response/response.dart';
import 'package:password/screen/save_data/domain/entities/account.dart';
import 'package:password/screen/save_data/domain/repository/save_repo.dart';
import 'package:password/screen/save_data/domain/use_case/save_data.dart';

class MockSaveRepo extends Mock implements SaveRepository {}

void main() {
  late SaveRepository repository;
  late SaveData saveData;

  setUpAll(() {
    repository = MockSaveRepo();
    saveData = SaveData(saveRepo: repository);
  });

  const account = Account.empty();
  var params = SaveDataParam.empty();
  test('should FutureResponse', () async {
    when(() => repository.saveData(account: account)).thenAnswer((_) async => const SuccessResponse("saved"));

    final result = await saveData(params);

    expect(result, equals(const SuccessResponse<dynamic>("saved")));

    verify(() => repository.saveData(account: account)).called(1);
    verifyNoMoreInteractions(repository);
  });
}
