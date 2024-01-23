import 'package:password/core/utiles/typedef.dart';

abstract class FetchDataRepository{
  const FetchDataRepository();
  FutureResponse fetchData();
}