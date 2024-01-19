import 'package:get/get.dart';

class NetworkConnectivityController extends GetxController {
  bool _connection = false;

  bool get connection => _connection;

  set connection(bool value) {
    if (_connection != value) {
      _connection = value;
      update();
    }
  }
}
