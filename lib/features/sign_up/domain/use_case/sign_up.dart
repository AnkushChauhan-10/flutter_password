import 'package:password/core/use_case/use_case_with_param.dart';
import 'package:password/core/utiles/typedef.dart';
import 'package:password/features/sign_up/domain/entities/sign_up.dart';
import 'package:password/features/sign_up/domain/repository/sign_up_repo.dart';

class SignUp extends UseCaseWithParams<FutureResponse, SingUpParams> {
  SignUp({required SignUpRepository singUpRepository}) : _singUpRepository = singUpRepository;
  final SignUpRepository _singUpRepository;

  @override
  FutureResponse call(SingUpParams params) async => await _singUpRepository.singUp(user: params.singUpDetails);
}

class SingUpParams {
  SingUpParams({
    required String email,
    required String name,
    required String password,
    required String phone,
  }) : singUpDetails = SignUpDetails(email: email, name: name, phone: phone, password: password);

  final SignUpDetails singUpDetails;
}
