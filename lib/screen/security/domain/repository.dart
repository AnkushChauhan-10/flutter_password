import 'package:password/core/utiles/typedef.dart';

abstract class PinRepository {
  const PinRepository();

  String pin();

  FutureResponse setPin(String pin);

  FutureResponse deletePin();
}
