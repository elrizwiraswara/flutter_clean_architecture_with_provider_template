// ignore_for_file: require_trailing_commas, depend_on_referenced_packages
// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter_clean_architecture_with_provider_template/services/notification/local_notif_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'local_notif_service_test.mocks.dart';

// Define an abstract class for the callback function
abstract class NotificationResponseCallback {
  void call(NotificationResponse response);
}

// Use the GenerateMocks annotation to generate mock classes
@GenerateMocks([
  FlutterLocalNotificationsPlugin,
  InitializationSettings,
  NotificationResponse,
  NotificationResponseCallback,
])
void main() {
  // Declare variables for the mock objects
  late MockFlutterLocalNotificationsPlugin mockLocalNotifPlugin;
  late MockInitializationSettings initSettings;
  late MockNotificationResponseCallback mockCallback;

  // Define a group of tests for the LocalNotifService
  group('$LocalNotifService', () {
    // Set up the mock objects before all tests
    setUpAll(() async {
      // Initialize the mock objects
      mockLocalNotifPlugin = MockFlutterLocalNotificationsPlugin();
      LocalNotifService.localNotifPlugin = mockLocalNotifPlugin;
      initSettings = MockInitializationSettings();
      LocalNotifService.initSettings = initSettings;
      mockCallback = MockNotificationResponseCallback();
    });

    // Define a group of tests for the instance
    group('instance', () {
      // Test that FlutterLocalNotificationsPlugin returns an instance
      test('FlutterLocalNotificationsPlugin should returns an instance', () async {
        expect(mockLocalNotifPlugin, isA<FlutterLocalNotificationsPlugin>());
      });
    });

    // Define a group of tests for the LocalNotifService
    group('LocalNotifService', () {
      // Set up the mock behavior before all tests
      setUpAll(() {
        when(mockCallback.call(any)).thenReturn(null);
        when(mockLocalNotifPlugin.getNotificationAppLaunchDetails()).thenAnswer((_) => Future.value());
        when(mockLocalNotifPlugin.initialize(initSettings, onDidReceiveNotificationResponse: mockCallback.call))
            .thenAnswer((_) => Future.value(true));
      });

      // Test that calling LocalNotifService.initLocalNotifService returns true
      test('Call LocalNotifService.initLocalNotifService() and should return true', () async {
        bool? res = await LocalNotifService.instance.initLocalNotifService(
          channelName: '',
          packageName: '',
          onDidReceiveNotificationResponse: mockCallback.call,
        );

        expect(res, true);
      });

      // Test that calling LocalNotifService.showNotification completes
      test('Call LocalNotifService.showNotification() and should complete', () async {
        await LocalNotifService.instance.initLocalNotifService(
          channelName: '',
          packageName: '',
          onDidReceiveNotificationResponse: mockCallback.call,
        );

        await expectLater(LocalNotifService.instance.showNotification(title: '', body: ''), completes);
      });
    });
  });
}
