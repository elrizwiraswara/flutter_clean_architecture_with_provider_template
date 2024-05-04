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

import './mock.dart';

void main() {
  setupFirebaseMessagingMocks();

  late FirebaseMessaging messaging;

  group('$FirebaseMessaging', () {
    setUpAll(() async {
      await Firebase.initializeApp();

      FirebaseMessagingPlatform.instance = kMockMessagingPlatform;
      messaging = FirebaseMessaging.instance;

      FcmService.messaging = messaging;
    });

    group('instance', () {
      test('FirebaseMessaging should returns an instance', () async {
        expect(messaging, isA<FirebaseMessaging>());
      });

      test('FirebaseMessaging should returns the correct $FirebaseApp', () {
        expect(messaging.app, isA<FirebaseApp>());
        expect(messaging.app.name, defaultFirebaseAppName);
      });
    });

    group('initNotification', () {
      setUpAll(() {
        when(kMockMessagingPlatform.getToken()).thenAnswer((_) => Future.value('token'));
        when(kMockMessagingPlatform.requestPermission()).thenAnswer((_) => Future.value(defaultNotificationSettings));
        when(kMockMessagingPlatform.getInitialMessage()).thenAnswer((_) => Future.value());
        when(kMockMessagingPlatform.subscribeToTopic(any)).thenAnswer((_) => Future.value());
        when(kMockMessagingPlatform.unsubscribeFromTopic(any)).thenAnswer((_) => Future.value());
      });

      test('Call FcmService.initNotification() and should not throw an error', () async {
        await expectLater(FcmService.initNotification(), completes);

        verify(FcmService.initNotification());
      });

      test('Call FcmService.initNotification() and should throw an error', () async {
        // Throw an error
        when(FcmService.initNotification()).thenThrow((e) => ServiceException(error: e.toString()));

        await expectLater(FcmService.initNotification(), throwsA(isA<ServiceException>()));

        verify(FcmService.initNotification());
      });
    });

    group("getToken", () {
      test('Call FcmService.getToken() and should return a String', () async {
        when(kMockMessagingPlatform.getToken()).thenAnswer((_) => Future.value('token'));

        var result = await FcmService.getToken();

        expect(result, 'token');

        verify(FcmService.getToken());
      });
    });

    group('subscribeTopics', () {
      test('Call FcmService.subscribeTopics() with correct args', () async {
        when(kMockMessagingPlatform.subscribeToTopic(any)).thenAnswer((_) => Future.value());

        const topic = 'test-topic';

        await FcmService.subscribeTopics([topic]);

        verify(FcmService.subscribeTopics([topic]));
      });

      test('Call FcmService.subscribeTopics() with incorrect args should throw AssertionError', () async {
        const topic = 'test invalid topic args';

        expectLater(FcmService.subscribeTopics([topic]), throwsAssertionError);
      });
    });

    group('unsubscribeFromTopic', () {
      test('Call FcmService.unsubscribeTopics() with correct args', () async {
        when(kMockMessagingPlatform.unsubscribeFromTopic(any)).thenAnswer((_) => Future.value());

        const topic = 'test-topic';

        await FcmService.unsubscribeTopics([topic]);

        verify(FcmService.unsubscribeTopics([topic]));
      });

      test('Call FcmService.unsubscribeTopics() with incorrect args should throw AssertionError', () async {
        const topic = 'test invalid topic args';

        expectLater(FcmService.unsubscribeTopics([topic]), throwsAssertionError);
      });
    });
  });
}
