import 'package:password/core/response/response.dart';
import 'package:password/features/delete/domain/use_case/delete.dart';
import 'package:password/features/fetch_db/domain/use_case/fetch_data.dart';
import 'package:password/features/fetch_db/domain/use_case/fetch_info.dart';

class FetchProvider {
  const FetchProvider({required FetchData fetchData, required FetchInfo fetchInfo})
      : _fetchData = fetchData,
        _fetchInfo = fetchInfo;
  final FetchData _fetchData;
  final FetchInfo _fetchInfo;

  Future<void> fetch(Function? onDone) async {
    final result = await _fetchData();
    if (result is SuccessResponse) {
      onDone?.call();
    } else {}
  }

  Future<void> fetchInfo(Function(bool) checkUpdate)async{
    final result = await _fetchInfo();
    if (result is SuccessResponse) {
      Stream<bool> stream = result.data as Stream<bool>;
      stream.listen((event) {
        checkUpdate.call(event);
      });
    } else {}
  }
}
