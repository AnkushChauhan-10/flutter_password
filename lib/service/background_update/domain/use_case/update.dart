import 'package:password/core/use_case/use_case_with_out_params.dart';
import 'package:password/core/utiles/typedef.dart';
import 'package:password/service/background_update/domain/repository/update_repository.dart';

class Update extends UseCaseWithOutParams<FutureResponse>{

  Update({required UpdateRepository repository}): _repository = repository;

  final UpdateRepository _repository;

  @override
  FutureResponse call() async => await _repository.update();

}