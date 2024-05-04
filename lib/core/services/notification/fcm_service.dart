import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_clean_architecture_with_provider_template/core/errors/exceptions.dart';

import '../../utilities/console_log.dart';
import 'local_notif_service.dart';

// FCM Service
// v.2.0.7
// by Elriz Wiraswara

class FcmService {
  // This class is not meant to be instatiated or extended; this constructor
  // prevents instantiation and extension.
  FcmService._();

  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static Future<String?> getToken({String? vapidKey}) async {
    var token = await messaging.getToken(vapidKey: vapidKey);
    cl('[FcmService].fcmToken = $token');
    return token;
  }

  static Future<void> initNotification({
    Function(RemoteMessage)? onMessageHandler,
    Future<void> Function(RemoteMessage)? onBackgroundHandler,
    Function(RemoteMessage?)? checkForInitialMessage,
    bool alert = true,
    bool badge = true,
    bool provisional = false,
    bool sound = true,
    List<String>? topics,
    String? vapidKey,
  }) async {
    try {
      // Get token
      await getToken(vapidKey: vapidKey);

      // On iOS, this helps to take the user permissions
      final settings = await messaging.requestPermission(
        alert: alert,
        badge: badge,
        provisional: provisional,
        sound: sound,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        _notificationHandler(
          onMessageHandler: onMessageHandler,
          onBackgroundHandler: onBackgroundHandler,
        );

        var initialMessage = await _checkForInitialMessage();
        if (checkForInitialMessage != null) checkForInitialMessage(initialMessage);

        subscribeTopics(topics ?? []);
      } else {
        cl('[FcmService].settings.authorizationStatus = ${settings.authorizationStatus}');
      }
    } catch (e) {
      throw ServiceException(error: e.toString());
    }
  }

  static Future<void> _notificationHandler({
    void Function(RemoteMessage)? onMessageHandler,
    Future<void> Function(RemoteMessage)? onBackgroundHandler,
  }) async {
    // Foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _onMessageHandler(message: message, onMessageHandler: onMessageHandler);
    });

    // Background
    if (onBackgroundHandler != null) {
      FirebaseMessaging.onBackgroundMessage(onBackgroundHandler);
    }
  }

  static void _onMessageHandler({
    required RemoteMessage message,
    Function(RemoteMessage)? onMessageHandler,
  }) async {
    LocalNotifService.showNotification(
      title: message.notification?.title,
      body: message.notification?.body,
      payload: json.encode(message.data),
      image: message.data['image'],
    );

    if (onMessageHandler != null) {
      onMessageHandler(message);
    }

    cl("[FcmService]._onMessageHandler.data = ${message.data}");
  }

  // For handling notification when the app is in terminated state
  static Future<RemoteMessage?> _checkForInitialMessage() async {
    var initialMessage = await messaging.getInitialMessage();

    cl("[FcmService]._checkForInitialMessage.data = ${initialMessage?.data}");

    return initialMessage;
  }

  static Future<void> subscribeTopics(List<String> topics) async {
    if (topics.isNotEmpty) {
      for (var topic in topics) {
        await messaging.subscribeToTopic(topic);
      }
    }
  }

  static Future<void> unsubscribeTopics(List<String> topics) async {
    if (topics.isNotEmpty) {
      for (var topic in topics) {
        await messaging.unsubscribeFromTopic(topic);
      }
    }
  }
}
