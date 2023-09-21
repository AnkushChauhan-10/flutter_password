import 'package:password/core/utiles/typedef.dart';

abstract class HomeRepository{
  const HomeRepository();

  FutureResponse getAccountsList();
  FutureResponse getUserData();
  FutureResponse signOut();
  FutureResponse deleteAccount(String siteName);
}