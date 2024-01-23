import 'package:password/core/use_case/use_case_with_out_params.dart';
import 'package:password/core/utiles/typedef.dart';
import 'package:password/features/fetch_db/domain/repository/fetch_info_repository.dart';

class FetchInfo extends UseCaseWithOutParams<FutureResponse> {
  FetchInfo({required FetchInfoRepository fetchInfoRepository}) : _fetchInfoRepository = fetchInfoRepository;
  final FetchInfoRepository _fetchInfoRepository;

  @override
  FutureResponse call() => _fetchInfoRepository.fetchInfo();
}
