import 'package:flutter_clean_architecture_with_provider_template/core/services/location/location_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:location/location.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'location_service_test.mocks.dart';

// This annotation is used to create a Mock class of Location
@GenerateMocks([Location])
void main() {
  // Declaring a variable of type MockLocation
  late MockLocation mockLocation;

  // Grouping tests related to LocationService
  group('$LocationService', () {
    // Setting up the mockLocation before all tests
    setUpAll(() async {
      // Initializing the mockLocation
      mockLocation = MockLocation();

      // Assigning the mockLocation to the location property of LocationService
      LocationService.location = mockLocation;
    });

    // Grouping tests related to 'instance'
    group('instance', () {
      // Test to check if mockLocation returns an instance
      test('mockLocation should returns an instance', () async {
        expect(mockLocation, isA<Location>());
      });
    });

    // Grouping tests related to 'getLocation'
    group('getLocation', () {
      // Setting up the mock responses for the methods of mockLocation
      setUpAll(() {
        when(mockLocation.serviceEnabled()).thenAnswer((_) => Future.value(true));
        when(mockLocation.requestService()).thenAnswer((_) => Future.value(true));
        when(mockLocation.requestPermission()).thenAnswer((_) => Future.value(PermissionStatus.granted));
        when(mockLocation.hasPermission()).thenAnswer((_) => Future.value(PermissionStatus.granted));
        when(mockLocation.getLocation()).thenAnswer((_) => Future.value(LocationData.fromMap({})));
      });

      // Test to check if LocationService.getCurrentPosition() returns a non-null value
      test('Call LocationService.getCurrentPosition() and then locationData should not be null', () async {
        var locationData = await LocationService.getCurrentPosition(
          onServiceDisabled: () {},
          onPermissionDenied: () {},
        );

        expect(locationData, isNotNull);
      });
    });
  });
}
