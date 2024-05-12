import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter_clean_architecture_with_provider_template/core/services/network/network_checker_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'network_checker_service_test.mocks.dart';

// Importing the necessary packages
@GenerateMocks([Connectivity, InternetConnectionChecker, HttpClient])
void main() {
  // Declaring the mock objects
  late MockConnectivity mockConnectivity;
  late MockInternetConnectionChecker mockInternetConnectionChecker;
  late MockHttpClient mockHttpClient;

  // Grouping the tests related to NetworkCheckerService
  group('$NetworkCheckerService', () {
    // Setting up the mock objects before all tests
    setUpAll(() async {
      mockConnectivity = MockConnectivity();
      mockInternetConnectionChecker = MockInternetConnectionChecker();
      mockHttpClient = MockHttpClient();

      // Assigning the mock objects to the NetworkCheckerService
      NetworkCheckerService.connectivity = mockConnectivity;
      NetworkCheckerService.internetConnectionChecker = mockInternetConnectionChecker;
      NetworkCheckerService.httpClient = mockHttpClient;
    });

    // Grouping the tests related to instance creation
    group('instance', () {
      // Testing if mockConnectivity returns an instance of Connectivity
      test('mockConnectivity should returns an instance', () async {
        expect(mockConnectivity, isA<Connectivity>());
      });
      // Testing if mockInternetConnectionChecker returns an instance of InternetConnectionChecker
      test('mockInternetConnectionChecker should returns an instance', () async {
        expect(mockInternetConnectionChecker, isA<InternetConnectionChecker>());
      });
      // Testing if mockHttpClient returns an instance of HttpClient
      test('mockHttpClient should returns an instance', () async {
        expect(mockHttpClient, isA<HttpClient>());
      });
    });

    // Grouping the tests related to the initialization of NetworkChecker
    group('initNetworkChecker', () {
      // Setting up the mock responses for the methods
      setUpAll(() {
        when(mockConnectivity.onConnectivityChanged)
            .thenAnswer((_) => Stream<ConnectivityResult>.value(ConnectivityResult.mobile));
        when(mockInternetConnectionChecker.hasConnection).thenAnswer((realInvocation) => Future.value(true));
      });

      // Testing if NetworkCheckerService.initNetworkChecker() completes
      test('Call NetworkCheckerService.initNetworkChecker() and should be complete', () async {
        await expectLater(NetworkCheckerService.initNetworkChecker(), completes);

        verify(NetworkCheckerService.initNetworkChecker());
      });

      // Testing if NetworkCheckerService.isConnected returns true after initialization
      test('Call NetworkCheckerService.isConnected after init and should return true', () async {
        await NetworkCheckerService.initNetworkChecker();

        expect(NetworkCheckerService.isConnected, true);
      });
    });

    // Grouping the tests related to NetworkChecker errors
    group('NetworkCheker Error Tests', () {
      // Setting up the mock responses for the methods
      setUpAll(() {
        when(mockConnectivity.onConnectivityChanged)
            .thenAnswer((_) => Stream<ConnectivityResult>.value(ConnectivityResult.none));
        when(mockInternetConnectionChecker.hasConnection).thenAnswer((realInvocation) => Future.value(false));
      });

      // Testing if NetworkCheckerService.isConnected returns false after initialization
      test('Call NetworkCheckerService.isConnected after init and should return false', () async {
        await NetworkCheckerService.initNetworkChecker();

        expect(NetworkCheckerService.isConnected, false);
      });
    });
  });
}
