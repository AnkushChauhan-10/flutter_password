import 'package:password/core/use_case/use_case_with_param.dart';
import 'package:password/core/utiles/typedef.dart';
import 'package:password/features/sign_in/domain/entities/sign_in_details.dart';
import 'package:password/features/sign_in/domain/repository/sign_in_repository.dart';

class SignIn extends UseCaseWithParams<FutureResponse, SignInParams> {
  SignIn({required SignInRepository signInRepository}) : _signInRepository = signInRepository;

  final SignInRepository _signInRepository;

  @override
  FutureResponse call(params) async => await _signInRepository.sigIn(user: params.signInDetails);
}

class SignInParams {
  SignInParams({required String email, required String password}) : signInDetails = SignInDetails(email: email, password: password);

  final SignInDetails signInDetails;
}
