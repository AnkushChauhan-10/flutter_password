import 'package:password/core/use_case/use_case_with_param.dart';
import 'package:password/core/utiles/typedef.dart';
import 'package:password/screen/update_account/domain/entities/update_account.dart';
import 'package:password/screen/update_account/domain/repository/update_repository.dart';

class Update extends UseCaseWithParams<FutureResponse, UpdateParams> {
  Update({required UpdateRepository updateRepository}) : _updateRepository = updateRepository;

  final UpdateRepository _updateRepository;

  @override
  FutureResponse call(UpdateParams params) async => await _updateRepository.update(params.account);
}

class UpdateParams {
  UpdateParams({
    required String email,
    required String title,
    required String password,
    required String userName,
    required String websiteURL,
  }) : account = UpdateAccount(
          title: title,
          websiteURL: websiteURL,
          email: email,
          userName: userName,
          password: password,
          lastUpdate: DateTime.now().toString(),
          isUpdate: false,
        );
  final UpdateAccount account;
}
