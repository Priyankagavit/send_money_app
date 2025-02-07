import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  StreamController<ConnectivityResult> connectivityController =
  StreamController<ConnectivityResult>.broadcast();

  Stream<ConnectivityResult> get connectivityStream =>
      connectivityController.stream;

  void initialize() {
    _connectivity.onConnectivityChanged.listen((result) {
      connectivityController.add(result);
    });
  }

  Future<bool> checkConnectivity() async {
    var result = await _connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }

  void dispose() {
    connectivityController.close();
  }
}