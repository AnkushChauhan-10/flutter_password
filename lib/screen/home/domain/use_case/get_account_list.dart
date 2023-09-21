import 'package:password/core/use_case/use_case_with_out_params.dart';
import 'package:password/core/utiles/typedef.dart';
import 'package:password/screen/home/domain/repository/home_repo.dart';


class GetUserData extends UseCaseWithOutParams<FutureResponse> {
  GetUserData({required HomeRepository homeRepository}) :_homeRepository = homeRepository;

  final HomeRepository _homeRepository;

  @override
  FutureResponse call() async => await _homeRepository.getUserData();

}
