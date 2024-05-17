import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_clean_architecture_with_provider_template/services/network/network_checker_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'network_checker_service_test.mocks.dart';

// Define the classes that you want to mock
@GenerateMocks([Connectivity, http.Client])
void main() {
  // Declaring the mock objects
  late MockConnectivity mockConnectivity;
  late MockClient mockClient;

  // Grouping the tests related to NetworkCheckerService
  group('$NetworkCheckerService', () {
    // Setting up the mock objects before all tests
    setUpAll(() async {
      mockConnectivity = MockConnectivity();
      mockClient = MockClient();

      // Assigning the mock objects to the NetworkCheckerService
      NetworkCheckerService.connectivity = mockConnectivity;
      NetworkCheckerService.client = mockClient;
    });

    // Grouping the tests related to instance creation
    group('instance', () {
      // Testing if mockConnectivity returns an instance of Connectivity
      test('mockConnectivity should returns an instance', () async {
        expect(mockConnectivity, isA<Connectivity>());
      });
      // Testing if mockClient returns an instance of HttpClient
      test('mockClient should returns an instance', () async {
        expect(mockClient, isA<http.Client>());
      });
    });

    // Grouping the tests related to the initialization of NetworkChecker
    group('initNetworkChecker', () {
      // Setting up the mock responses for the methods
      setUpAll(() {
        when(mockConnectivity.onConnectivityChanged)
            .thenAnswer((_) => Stream<List<ConnectivityResult>>.value([ConnectivityResult.mobile]));
        when(mockClient.get(any)).thenAnswer((_) async => http.Response('', 200));
      });

      // Testing if NetworkCheckerService.initNetworkChecker() completes
      test('Call NetworkCheckerService.initNetworkChecker() and should be complete', () async {
        await expectLater(NetworkCheckerService.initNetworkChecker(), completes);
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
            .thenAnswer((_) => Stream<List<ConnectivityResult>>.value([ConnectivityResult.mobile]));
        when(mockClient.get(any)).thenAnswer((_) async => http.Response('', 201));
      });

      // Testing if NetworkCheckerService.isConnected returns false after initialization
      test('Call NetworkCheckerService.isConnected after init and should return false', () async {
        await NetworkCheckerService.initNetworkChecker();

        expect(NetworkCheckerService.isConnected, false);
      });
    });
  });
}
