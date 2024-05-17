import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

import '../../core/errors/exceptions.dart';
import '../../utilities/console_log.dart';
import '../../utilities/external_launcher.dart';
import '../navigation/navigation_service.dart';

// Local Notification Service
// v.2.0.4
// by Elriz Wiraswara

class LocalNotifService {
  // This class is not meant to be instatiated or extended; this constructor
  // prevents instantiation and extension.
  LocalNotifService._();

  static LocalNotifService instance = LocalNotifService._();

  static late final String _defaultPackageName;
  static late final String _defaultChannelName;

  static bool _isInitialized = false;

  // Notification icon
  static const String _notificationIcon = '@mipmap/ic_launcher';

  // Flutter local notification plugin
  static FlutterLocalNotificationsPlugin localNotifPlugin = FlutterLocalNotificationsPlugin();

  // Initilaization settings
  static const _androidInitSettings = AndroidInitializationSettings(_notificationIcon);

  static const _iosInitSettings = DarwinInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
  );

  static InitializationSettings initSettings = const InitializationSettings(
    android: _androidInitSettings,
    iOS: _iosInitSettings,
  );

  // Notification details settings
  static late AndroidNotificationDetails _androidNotifDetails;

  static late DarwinNotificationDetails _iosNotifDetails;

  static late NotificationDetails _notificationDetails;

  Future<bool?> initLocalNotifService({
    required String packageName,
    required String channelName,
    String? categoryIdentifier,
    String? description,
    String? icon,
    Importance importance = Importance.defaultImportance,
    Priority priority = Priority.high,
    Function(NotificationResponse)? onDidReceiveNotificationResponse,
  }) async {
    try {
      if (_isInitialized) {
        return true;
      }

      _defaultPackageName = packageName;
      _defaultChannelName = channelName;

      _androidNotifDetails = AndroidNotificationDetails(
        packageName,
        channelName,
        channelDescription: description,
        importance: importance,
        priority: priority,
        icon: icon ?? _notificationIcon,
      );

      _iosNotifDetails = DarwinNotificationDetails(
        categoryIdentifier: categoryIdentifier,
      );

      _notificationDetails = NotificationDetails(
        android: _androidNotifDetails,
        iOS: _iosNotifDetails,
      );

      var notifAppLaunchDetails = await localNotifPlugin.getNotificationAppLaunchDetails();

      if (notifAppLaunchDetails?.didNotificationLaunchApp ?? false) {
        onDidReceiveNotificationResponse ?? _onDidReceiveNotif(notifAppLaunchDetails!.notificationResponse!);
      }

      _isInitialized = await localNotifPlugin.initialize(
            initSettings,
            onDidReceiveNotificationResponse: onDidReceiveNotificationResponse ?? _onDidReceiveNotif,
          ) ??
          false;

      return _isInitialized;
    } catch (e) {
      cl(['[initLocalNotifService].error = $e']);
      throw ServiceException(error: e.toString());
    }
  }

  static void _onDidReceiveNotif(NotificationResponse res) async {
    if (res.notificationResponseType == NotificationResponseType.selectedNotification) {
      if (res.payload == null || res.payload == '') {
        return;
      }

      if (await File(res.payload!).exists()) {
        OpenFilex.open(res.payload);
      } else if (res.payload!.contains('http')) {
        ExternalLauncher.openUrl(res.payload!);
      } else {
        NavigationService.navigatorKey.currentState?.pushNamed(res.payload!);
      }
    }
  }

  Future<void> showNotification({
    required String? title,
    required String? body,
    String? image,
    String? payload,
  }) async {
    await localNotifPlugin.show(
      body.hashCode,
      title,
      body,
      payload: payload,
      image == null
          ? _notificationDetails
          : NotificationDetails(
              android: AndroidNotificationDetails(
                _defaultPackageName,
                _defaultChannelName,
                styleInformation: await _buildBigPictureStyleInformation(image),
              ),
              // TODO
              iOS: const DarwinNotificationDetails(),
            ),
    );
  }

  static Future<BigPictureStyleInformation?> _buildBigPictureStyleInformation(String image) async {
    final imgPath = await _downloadAndSaveFile(image, "notifImage");

    final FilePathAndroidBitmap filePath = FilePathAndroidBitmap(imgPath);

    return BigPictureStyleInformation(
      filePath,
      htmlFormatContentTitle: true,
      htmlFormatSummaryText: true,
    );
  }

  Future<void> showDownloadProgressNotification({
    required String? title,
    required String? body,
    required String? payload,
    required int count,
    required int i,
    required int id,
  }) async {
    //show the notifications.
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      body.hashCode.toString(),
      'Download Progess Channel',
      channelDescription: 'Download Progess Notification Channel',
      channelShowBadge: false,
      importance: Importance.max,
      priority: Priority.high,
      onlyAlertOnce: true,
      showProgress: true,
      maxProgress: count,
      progress: i,
    );

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await localNotifPlugin.show(
      id++,
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );
  }

  static Future<String> _downloadAndSaveFile(String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  Future<void> cancelNotification(int id, {String? tag}) async {
    return localNotifPlugin.cancel(id, tag: tag);
  }
}
