import 'package:password/core/use_case/use_case_with_param.dart';
import 'package:password/core/utiles/typedef.dart';
import 'package:password/features/save_data/domain/entities/account.dart';
import 'package:password/features/save_data/domain/repository/save_repo.dart';

class SaveData extends UseCaseWithParams<FutureResponse, SaveDataParam> {
  final SaveRepository saveRepo;

  SaveData({required this.saveRepo});

  @override
  FutureResponse call(SaveDataParam params) async => await saveRepo.saveData(account: params.account);
}

class SaveDataParam {
  final Account account;

  SaveDataParam.empty() : account = const Account.empty();

  SaveDataParam({
    required String siteName,
    required String userName,
    required String id,
    required String password,
    required String lastUpdate,
  }) : account = Account(siteName: siteName, id: id, userName: userName, password: password, lastUpdate: lastUpdate, isUpdate: false);
}
