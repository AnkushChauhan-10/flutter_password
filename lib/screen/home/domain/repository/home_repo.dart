import 'package:password/core/utiles/typedef.dart';

abstract class HomeRepository{
  const HomeRepository();

  FutureResponse getUsers();
  FutureResponse loggedUser();
  FutureResponse changeUser(String token);
}