// ignore_for_file: require_trailing_commas, depend_on_referenced_packages
// ignore_for_file: avoid_redundant_argument_values

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_messaging_platform_interface/firebase_messaging_platform_interface.dart';
import 'package:firebase_messaging_platform_interface/src/utils.dart';
import 'package:flutter_clean_architecture_with_provider_template/core/errors/exceptions.dart';
import 'package:flutter_clean_architecture_with_provider_template/core/services/notification/fcm_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'mock_fcm.dart';

// Set up Firebase Messaging mocks
void main() {
  setupFirebaseMessagingMocks();

  // Declare a variable for FirebaseMessaging
  late FirebaseMessaging messaging;

  // Define a group of tests for FirebaseMessaging
  group('$FirebaseMessaging', () {
    // Set up the test environment before all tests
    setUpAll(() async {
      // Initialize Firebase app
      await Firebase.initializeApp();

      // Set the instance of FirebaseMessagingPlatform to the mock platform
      FirebaseMessagingPlatform.instance = kMockMessagingPlatform;
      // Get the instance of FirebaseMessaging
      messaging = FirebaseMessaging.instance;

      // Set the messaging in FcmService to the instance of FirebaseMessaging
      FcmService.messaging = messaging;
    });

    // Define a group of tests for the instance
    group('instance', () {
      // Test that FirebaseMessaging returns an instance
      test('FirebaseMessaging should returns an instance', () async {
        expect(messaging, isA<FirebaseMessaging>());
      });

      // Test that FirebaseMessaging returns the correct FirebaseApp
      test('FirebaseMessaging should returns the correct $FirebaseApp', () {
        expect(messaging.app, isA<FirebaseApp>());
        expect(messaging.app.name, defaultFirebaseAppName);
      });
    });

    // Define a group of tests for the initNotification function
    group('initNotification', () {
      // Set up the mock behavior before all tests
      setUpAll(() {
        when(kMockMessagingPlatform.getToken()).thenAnswer((_) => Future.value('token'));
        when(kMockMessagingPlatform.requestPermission()).thenAnswer((_) => Future.value(defaultNotificationSettings));
        when(kMockMessagingPlatform.getInitialMessage()).thenAnswer((_) => Future.value());
        when(kMockMessagingPlatform.subscribeToTopic(any)).thenAnswer((_) => Future.value());
        when(kMockMessagingPlatform.unsubscribeFromTopic(any)).thenAnswer((_) => Future.value());
      });

      // Test that calling FcmService.initNotification does not throw an error
      test('Call FcmService.initNotification() and should not throw an error', () async {
        await expectLater(FcmService.initNotification(), completes);

        verify(FcmService.initNotification());
      });

      // Test that calling FcmService.initNotification throws an error
      test('Call FcmService.initNotification() and should throw an error', () async {
        // Define the behavior of the initNotification function to throw an error
        when(FcmService.initNotification()).thenThrow((e) => ServiceException(error: e.toString()));

        await expectLater(FcmService.initNotification(), throwsA(isA<ServiceException>()));

        verify(FcmService.initNotification());
      });
    });

    // Define a group of tests for the getToken function
    group("getToken", () {
      // Test that calling FcmService.getToken returns a string
      test('Call FcmService.getToken() and should return a String', () async {
        // Define the behavior of the getToken function
        when(kMockMessagingPlatform.getToken()).thenAnswer((_) => Future.value('token'));

        var result = await FcmService.getToken();

        expect(result, 'token');

        verify(FcmService.getToken());
      });
    });

    // Define a group of tests for the subscribeTopics function
    group('subscribeTopics', () {
      // Test that calling FcmService.subscribeTopics with correct arguments
      test('Call FcmService.subscribeTopics() with correct args', () async {
        // Define the behavior of the subscribeToTopic function
        when(kMockMessagingPlatform.subscribeToTopic(any)).thenAnswer((_) => Future.value());

        const topic = 'test-topic';

        await FcmService.subscribeTopics([topic]);

        verify(FcmService.subscribeTopics([topic]));
      });

      // Test that calling FcmService.subscribeTopics with incorrect arguments throws an AssertionError
      test('Call FcmService.subscribeTopics() with incorrect args should throw AssertionError', () async {
        const topic = 'test invalid topic args';

        expectLater(FcmService.subscribeTopics([topic]), throwsAssertionError);
      });
    });

    // Define a group of tests for the unsubscribeFromTopic function
    group('unsubscribeFromTopic', () {
      // Test that calling FcmService.unsubscribeTopics with correct arguments
      test('Call FcmService.unsubscribeTopics() with correct args', () async {
        // Define the behavior of the unsubscribeFromTopic function
        when(kMockMessagingPlatform.unsubscribeFromTopic(any)).thenAnswer((_) => Future.value());

        const topic = 'test-topic';

        await FcmService.unsubscribeTopics([topic]);

        verify(FcmService.unsubscribeTopics([topic]));
      });

      // Test that calling FcmService.unsubscribeTopics with incorrect arguments throws an AssertionError
      test('Call FcmService.unsubscribeTopics() with incorrect args should throw AssertionError', () async {
        const topic = 'test invalid topic args';

        expectLater(FcmService.unsubscribeTopics([topic]), throwsAssertionError);
      });
    });
  });
}
