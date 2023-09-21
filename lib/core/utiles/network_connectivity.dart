import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkConnectivity {
  const NetworkConnectivity();

  Future<bool> isConnected() async {
    ConnectivityResult result = await Connectivity().checkConnectivity();
    return result.name == "none" ? false : true;
  }

  Stream<bool> checkConnection() async* {
    
  }
}
