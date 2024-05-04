import 'package:flutter_clean_architecture_with_provider_template/core/services/network/network_checker_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('NetworkCheckerService', () {
    test('should return true when there is an internet connection', () async {
      await NetworkCheckerService.initNetworkChecker();

      expect(NetworkCheckerService.isConnected, true);
    });
  });
}

// class MockConnectivity extends Mock implements Connectivity {}

// class MockInternetConnectionChecker extends Mock implements InternetConnectionChecker {}

// class MockHttpClient extends Mock implements HttpClient {}

// void main() {
//   TestWidgetsFlutterBinding.ensureInitialized();

//   late MockConnectivity mockConnectivity;
//   late MockInternetConnectionChecker mockInternetConnectionChecker;
//   late MockHttpClient mockHttpClient;

//   group('$NetworkCheckerService', () {
//     setUpAll(() async {
//       mockConnectivity = MockConnectivity();
//       mockInternetConnectionChecker = MockInternetConnectionChecker();
//       mockHttpClient = MockHttpClient();

//       NetworkCheckerService.connectivity = mockConnectivity;
//       NetworkCheckerService.internetConnectionChecker = mockInternetConnectionChecker;
//       NetworkCheckerService.httpClient = mockHttpClient;
//     });

//     group('instance', () {
//       test('mockConnectivity should returns an instance', () async {
//         expect(mockConnectivity, isA<Connectivity>());
//       });
//       test('mockInternetConnectionChecker should returns an instance', () async {
//         expect(mockInternetConnectionChecker, isA<InternetConnectionChecker>());
//       });
//       test('mockHttpClient should returns an instance', () async {
//         expect(mockHttpClient, isA<HttpClient>());
//       });
//     });

//     group('initNetworkChecker', () {
//       setUpAll(() {
//         when(mockConnectivity.onConnectivityChanged)
//             .thenAnswer((_) => Stream<ConnectivityResult>.value(ConnectivityResult.mobile));
//         when(mockInternetConnectionChecker.hasConnection).thenAnswer((realInvocation) => Future.value(true));
//       });

//       test('Call NetworkCheckerService.initNetworkChecker() and should be complete', () async {
//         await expectLater(NetworkCheckerService.initNetworkChecker(), completes);

//         verify(NetworkCheckerService.initNetworkChecker());
//       });

//       test('Call NetworkCheckerService.isConnected after init and should return true', () async {
//         await NetworkCheckerService.initNetworkChecker();

//         expect(NetworkCheckerService.isConnected, true);
//       });

//       test('Call NetworkCheckerService.isConnected after init and should return false', () async {
//         when(mockConnectivity.onConnectivityChanged)
//             .thenAnswer((realInvocation) => Stream.value(ConnectivityResult.none));

//         await NetworkCheckerService.initNetworkChecker();

//         expect(NetworkCheckerService.isConnected, false);
//       });
//     });
//   });
// }
