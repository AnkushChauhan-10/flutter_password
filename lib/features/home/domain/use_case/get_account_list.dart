import 'package:password/core/use_case/use_case_with_out_params.dart';
import 'package:password/core/use_case/use_case_with_param.dart';
import 'package:password/core/utiles/typedef.dart';
import 'package:password/features/home/domain/entities/account_data.dart';
import 'package:password/features/home/domain/repository/home_repo.dart';

class GetAccountList extends UseCaseWithOutParams<FutureResponse> {
  GetAccountList({required HomeRepository homeRepository}) : _homeRepo = homeRepository;
  final HomeRepository _homeRepo;

  @override
  FutureResponse call() async => await _homeRepo.getAccountsList();
}

class GetUserData extends UseCaseWithOutParams<FutureResponse> {
  GetUserData({required HomeRepository homeRepository}) :_homeRepository = homeRepository;

  final HomeRepository _homeRepository;

  @override
  FutureResponse call() async => await _homeRepository.getUserData();

}

class SignOut extends UseCaseWithOutParams<FutureResponse> {
  SignOut({required HomeRepository homeRepository}) :_homeRepository = homeRepository;

  final HomeRepository _homeRepository;

  @override
  FutureResponse call() async => await  _homeRepository.signOut();
}

class DeleteAccount extends UseCaseWithParams<FutureResponse,String>{

  DeleteAccount({required HomeRepository homeRepository}) :_homeRepository = homeRepository;

  final HomeRepository _homeRepository;

  @override
  FutureResponse call(String params) => _homeRepository.deleteAccount(params);

}