// ignore_for_file: require_trailing_commas, depend_on_referenced_packages
// ignore_for_file: avoid_redundant_argument_values

// import 'package:flutter_clean_architecture_with_provider_template/core/services/notification/local_notif_service.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';

// TODO can't do unit testing because [FlutterLocalNotificationsPlugin] depend on native channel

// class MockFlutterLocalNotificationsPlugin extends Mock implements FlutterLocalNotificationsPlugin {}

// void main() {
//   late MockFlutterLocalNotificationsPlugin mockLocalNotifPlugin;

//   InitializationSettings initSettings = const InitializationSettings(
//     android: AndroidInitializationSettings('@mipmap/ic_launcher'),
//     iOS: DarwinInitializationSettings(),
//   );

//   group('$LocalNotifService', () {
//     setUpAll(() async {
//       mockLocalNotifPlugin = MockFlutterLocalNotificationsPlugin();
//       LocalNotifService.localNotifPlugin = mockLocalNotifPlugin;
//     });

//     group('instance', () {
//       test('FlutterLocalNotificationsPlugin should returns an instance', () async {
//         expect(mockLocalNotifPlugin, isA<FlutterLocalNotificationsPlugin>());
//       });
//     });

//     group('initNotification', () {
//       setUpAll(() {
//         when(mockLocalNotifPlugin.getNotificationAppLaunchDetails()).thenAnswer((_) => Future.value());
//         when(mockLocalNotifPlugin.initialize(initSettings, onDidReceiveNotificationResponse: (_) {}))
//             .thenAnswer((_) => Future.value(true));
//       });

//       test('Call LocalNotifService.initLocalNotifService() and should return true', () async {
//         bool? res = await LocalNotifService.initLocalNotifService(channelName: '', packageName: '');

//         expect(res, true);

//         verify(LocalNotifService.initLocalNotifService(channelName: '', packageName: ''));
//       });
//     });

//     group('showNotification', () {
//       setUpAll(() {
//         when(mockLocalNotifPlugin.getNotificationAppLaunchDetails()).thenAnswer((_) => Future.value());
//         when(mockLocalNotifPlugin.initialize(initSettings, onDidReceiveNotificationResponse: (_) {}))
//             .thenAnswer((_) => Future.value(true));
//       });

//       test('Call LocalNotifService.showNotification() and should complete', () async {
//         await LocalNotifService.initLocalNotifService(channelName: '', packageName: '');

//         await expectLater(LocalNotifService.showNotification(title: '', body: ''), completes);

//         verify(LocalNotifService.showNotification(title: '', body: ''));
//       });
//     });
//   });
// }
