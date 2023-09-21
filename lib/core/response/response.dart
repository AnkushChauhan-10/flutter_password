import 'package:equatable/equatable.dart';

abstract class Response<T> extends Equatable{
  final T data;
  const Response({required this.data});
}

class SuccessResponse<T> extends Response<T>{
  const SuccessResponse(T data) : super(data: data);
  @override
  List<Object?> get props => [data];
}

class FailureResponse<T> extends Response<T>{
  const FailureResponse(T data): super(data: data);

  @override
  List<Object?> get props => [data];
}