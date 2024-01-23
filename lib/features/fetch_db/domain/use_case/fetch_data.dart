import 'package:password/core/use_case/use_case_with_out_params.dart';
import 'package:password/core/utiles/typedef.dart';
import 'package:password/features/fetch_db/domain/repository/fetch_data_repository.dart';

class FetchData extends UseCaseWithOutParams<FutureResponse> {
  FetchData({required FetchDataRepository fetchDataRepository}) : _fetchDataRepository = fetchDataRepository;
  final FetchDataRepository _fetchDataRepository;

  @override
  FutureResponse call() async => await _fetchDataRepository.fetchData();
}
