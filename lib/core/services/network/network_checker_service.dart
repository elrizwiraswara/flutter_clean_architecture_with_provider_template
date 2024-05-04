import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../utilities/console_log.dart';

// Network Checker Service
// v.3.0.3
// by Elriz Wiraswara

class NetworkCheckerService {
  // This class is not meant to be instatiated or extended; this constructor
  // prevents instantiation and extension.
  NetworkCheckerService._();

  static Connectivity connectivity = Connectivity();

  static InternetConnectionChecker internetConnectionChecker = InternetConnectionChecker();

  static HttpClient httpClient = HttpClient();

  static bool isConnected = false;

  static StreamSubscription<ConnectivityResult>? _subscription;

  static Future<void> initNetworkChecker({Function(bool)? onHasInternet}) async {
    await _checkInternetConnection();

    _subscription = connectivity.onConnectivityChanged.listen((ConnectivityResult result) async {
      if (result != ConnectivityResult.none) {
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
    if (!kIsWeb) {
      isConnected = await internetConnectionChecker.hasConnection;
    } else {
      final res = await httpClient.get("www.google.com", 80, '/');
      if ((await res.close()).statusCode == 200) {
        isConnected = true;
      } else {
        isConnected = false;
      }
    }
  }

  static void cancelSubs() {
    _subscription?.cancel();
  }
}
