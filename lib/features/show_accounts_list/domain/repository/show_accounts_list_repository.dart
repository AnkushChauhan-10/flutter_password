import 'package:password/core/response/response.dart';
import 'package:password/core/utiles/typedef.dart';

abstract class ShowAccountsListRepository{
  const ShowAccountsListRepository();
  Stream<Response> getAccountsList();
}