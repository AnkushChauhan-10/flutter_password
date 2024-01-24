import 'package:password/core/use_case/use_case_with_param.dart';
import 'package:password/core/utiles/typedef.dart';
import 'package:password/screen/account/domain/repository/save_repo.dart';
import 'package:password/screen/save_data/domain/entities/account.dart';

class EditData extends UseCaseWithParams<FutureResponse, EditDataParam> {
  final EditRepository editRepo;

  EditData({required this.editRepo});

  @override
  FutureResponse call(EditDataParam params) async => await editRepo.editData(account: params.account);
}

class EditDataParam {
  final Account account;

  EditDataParam.empty() : account = const Account.empty();

  EditDataParam({
    required String title,
    required String userId,
    required String password,
    required num lastUpdate,
  }) : account = Account(
          title: title,
          userId: userId,
          password: password,
          lastUpdate: lastUpdate,
        );
}
