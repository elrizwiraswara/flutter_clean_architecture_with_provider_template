import 'package:flutter_clean_architecture_with_provider_template/core/services/location/location_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('LocationService', () {
    test('should return not null', () async {
      await LocationService.getCurrentPosition(onPermissionDenied: () {}, onServiceDisabled: () {});

      expect(LocationService.location, isNotNull);
    });
  });
}

// class MockLocation extends Mock implements Location {}

// void main() {
//   TestWidgetsFlutterBinding.ensureInitialized();

//   late MockLocation mockLocation;

//   group('$LocationService', () {
//     setUpAll(() async {
//       mockLocation = MockLocation();

//       LocationService.location = mockLocation;
//     });

//     group('instance', () {
//       test('mockLocation should returns an instance', () async {
//         expect(mockLocation, isA<Location>());
//       });
//     });

//     group('getLocation', () {
//       setUpAll(() {
//         when(mockLocation.serviceEnabled()).thenAnswer((_) => Future.value(true));
//         when(mockLocation.requestService()).thenAnswer((_) => Future.value(true));
//         when(mockLocation.requestPermission()).thenAnswer((_) => Future.value(PermissionStatus.granted));
//         when(mockLocation.hasPermission()).thenAnswer((_) => Future.value(PermissionStatus.granted));
//         when(mockLocation.hasPermission()).thenAnswer((_) => Future.value(PermissionStatus.granted));
//       });

//       test('Call NetworkCheckerService.initNetworkChecker() and should be complete', () async {
//         var locationData =
//             await LocationService.getCurrentPosition(onServiceDisabled: () {}, onPermissionDenied: () {});

//         expect(locationData, isNotNull);
//       });
//     });
//   });
// }
