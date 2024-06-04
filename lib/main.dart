import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clean_architecture_with_provider_template/widgets/error_handler_widget.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import 'core/locale/app_locale.dart';
import 'core/routes/app_routes.dart';
import 'service_locator.dart';
import 'services/notification/fcm_service.dart';
import 'services/notification/local_notif_service.dart';
import 'themes/app_theme.dart';

void main() async {
  // Initialize binding
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize date formatting
  initializeDateFormatting();

  // Setup service locator
  setupServiceLocator();

  // Initialize multiple futures
  await Future.wait([
    // Initialize Firebase (google-service.json required)
    FcmService.initNotification(
      onMessageHandler: (message) {},
      onBackgroundHandler: (message) async {},
    ),

    // Initialize local notification service
    LocalNotifService.instance.initLocalNotifService(
      packageName: "com.example.app",
      channelName: "example notification",
    )
  ]);

  // Set/lock orientationgvhvgj
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme().init(context);

    return MultiProvider(
      providers: const [
        // Providers
      ],
      child: MaterialApp.router(
        title: 'Flutter Template',
        theme: theme,
        debugShowCheckedModeBanner: kDebugMode,
        routerConfig: AppRoutes.router,
        locale: AppLocale.defaultLocale,
        supportedLocales: AppLocale.supportedLocales,
        localizationsDelegates: AppLocale.localizationsDelegates,
        builder: (context, child) => ErrorHandlerWidget(child: child),
      ),
    );
  }
}
