import 'package:password/core/use_case/use_case_with_out_params.dart';
import 'package:password/core/use_case/use_case_with_param.dart';
import 'package:password/core/utiles/typedef.dart';
import 'package:password/screen/security/domain/repository.dart';

class Pin extends UseCaseWithOutParams<String> {
  Pin({required PinRepository pinRepository}) : _pinRepository = pinRepository;

  final PinRepository _pinRepository;

  @override
  String call() => _pinRepository.pin();
}

class SetPin extends UseCaseWithParams<FutureResponse, String> {
  SetPin({required PinRepository pinRepository}) : _pinRepository = pinRepository;

  final PinRepository _pinRepository;

  @override
  FutureResponse call(String params) async => await _pinRepository.setPin(params);
}

class DeletePin extends UseCaseWithOutParams<FutureResponse> {
  DeletePin({required PinRepository pinRepository}) : _pinRepository = pinRepository;

  final PinRepository _pinRepository;

  @override
  FutureResponse call() async => _pinRepository.deletePin();
}
