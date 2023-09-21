import 'package:password/core/use_case/use_case_with_out_params.dart';
import 'package:password/core/utiles/typedef.dart';
import 'package:password/features/sign_out/domain/repository/sign_out_repository.dart';

class SignOut extends UseCaseWithOutParams<FutureResponse> {
  SignOut({required SignOutRepository signOutRepository}) : _repository = signOutRepository;

  final SignOutRepository _repository;

  @override
  FutureResponse call() async => await _repository.signOut();
}
