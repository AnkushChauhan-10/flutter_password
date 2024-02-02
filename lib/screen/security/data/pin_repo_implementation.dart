import 'package:password/core/response/response.dart';
import 'package:password/core/utiles/typedef.dart';
import 'package:password/screen/security/data/pin_data_source.dart';
import 'package:password/screen/security/domain/repository.dart';

class PinRepoImplementation extends PinRepository {
  const PinRepoImplementation({required PinDataSource pinDataSource}) : _pinDataSource = pinDataSource;

  final PinDataSource _pinDataSource;

  @override
  String pin() => _pinDataSource.pin();

  @override
  FutureResponse deletePin() async {
    try {
      final res = await _pinDataSource.deletePin();
      return SuccessResponse(res);
    } catch (e) {
      return FailureResponse(e);
    }
  }

  @override
  FutureResponse setPin(String pin) async {
    try {
      final res = await _pinDataSource.setPin(pin);
      return SuccessResponse(res);
    } catch (e) {
      return FailureResponse(e);
    }
  }
}
