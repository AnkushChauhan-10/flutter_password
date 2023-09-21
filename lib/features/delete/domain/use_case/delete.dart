import 'package:password/core/use_case/use_case_with_param.dart';
import 'package:password/core/utiles/typedef.dart';
import 'package:password/features/delete/domain/repository/delete_repository.dart';

class Delete extends UseCaseWithParams<FutureResponse, String> {
  Delete({required DeleteRepository deleteRepository}) : _deleteRepository = deleteRepository;

  final DeleteRepository _deleteRepository;

  @override
  FutureResponse call(String params) async => await _deleteRepository.delete(params);
}
