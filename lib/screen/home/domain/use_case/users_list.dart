import 'package:password/core/use_case/use_case_with_out_params.dart';
import 'package:password/core/use_case/use_case_with_param.dart';
import 'package:password/core/utiles/typedef.dart';
import 'package:password/screen/home/domain/repository/home_repo.dart';

class GetUsers extends UseCaseWithOutParams<FutureResponse> {
  GetUsers({required HomeRepository homeRepository}) : _homeRepository = homeRepository;

  final HomeRepository _homeRepository;

  @override
  FutureResponse call() async => await _homeRepository.getUsers();
}

class GetLoggedUser extends UseCaseWithOutParams<FutureResponse> {
  GetLoggedUser({required HomeRepository homeRepository}) : _homeRepository = homeRepository;

  final HomeRepository _homeRepository;

  @override
  FutureResponse call() async => await _homeRepository.loggedUser();
}

class ChangeAccount extends UseCaseWithParams<FutureResponse,String> {
  ChangeAccount({required HomeRepository homeRepository}) : _homeRepository = homeRepository;

  final HomeRepository _homeRepository;

  @override
  FutureResponse call(String params) async => await _homeRepository.changeUser(params);

}
