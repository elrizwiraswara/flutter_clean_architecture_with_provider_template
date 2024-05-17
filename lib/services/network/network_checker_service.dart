import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

import '../../utilities/console_log.dart';

// Network Checker Service
// v.4.0.0
// by Elriz Wiraswara

class NetworkCheckerService {
  // This class is not meant to be instatiated or extended; this constructor
  // prevents instantiation and extension.
  NetworkCheckerService._();

  static Connectivity connectivity = Connectivity();

  static http.Client client = http.Client();

  static String host = 'google.com';

  static bool isConnected = false;

  static StreamSubscription<List<ConnectivityResult>>? _subscription;

  static Future<void> initNetworkChecker({Function(bool)? onHasInternet}) async {
    await _checkInternetConnection();

    _subscription = connectivity.onConnectivityChanged.listen((results) async {
      var internetConnectivityList = [
        ConnectivityResult.mobile,
        ConnectivityResult.wifi,
        ConnectivityResult.ethernet,
        ConnectivityResult.vpn,
      ];

      if (results.every((e) => internetConnectivityList.contains(e))) {
        await _checkInternetConnection();

        if (onHasInternet != null) {
          onHasInternet(isConnected);
        }
      } else {
        isConnected = false;
      }

      cl('[NetworkCheckerService].isConnected = $isConnected ');
    });
  }

  static Future<void> _checkInternetConnection() async {
    var response = await client.get(Uri.http(host));

    if (response.statusCode == 200) {
      isConnected = true;
    } else {
      isConnected = false;
    }
  }

  static void cancelSubs() {
    _subscription?.cancel();
  }
}
