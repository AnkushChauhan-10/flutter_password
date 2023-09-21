import 'package:password/core/utiles/typedef.dart';

abstract class ShowAccountsListRepository{
  const ShowAccountsListRepository();
  FutureResponse getAccountsList();
}