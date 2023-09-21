import 'package:password/core/utiles/typedef.dart';

abstract class DeleteRepository{
  FutureResponse delete(String name);
}