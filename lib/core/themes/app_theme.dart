import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'app_text_style.dart';

// App Theme
// v.2.0.0
// by Elriz Wiraswara

// App Theme
class AppTheme {
  // This class is not meant to be instatiated or extended; this constructor
  // prevents instantiation and extension.
  AppTheme._();

  // App Theme mode
  static bool isLightMode = true;

  // Light Ui Overlay Style
  static const lightOverlayStyle = SystemUiOverlayStyle(
    systemNavigationBarColor: AppColors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
    statusBarColor: AppColors.white,
    statusBarIconBrightness: Brightness.dark,
  );

  // Dark Ui Overlay Style
  static const darkOverlayStyle = SystemUiOverlayStyle(
    systemNavigationBarColor: AppColors.black,
    systemNavigationBarIconBrightness: Brightness.light,
    statusBarColor: AppColors.black,
    statusBarIconBrightness: Brightness.light,
  );

  // App Theme selector
  static ThemeData themeSelector() {
    return isLightMode ? lightTheme() : darkTheme();
  }

  // Light Theme
  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: false,
      scaffoldBackgroundColor: AppColors.white,
      hintColor: AppColors.blackLv4,
      disabledColor: AppColors.blackLv4,
      fontFamily: AppTextStyle.defaultFontFamily,
      primaryColor: AppColors.primary,
      primarySwatch: AppColors.mainColor,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      iconTheme: const IconThemeData(color: AppColors.blackLv1),
      primaryIconTheme: const IconThemeData(color: AppColors.blackLv1),
      dividerTheme: const DividerThemeData(
        color: AppColors.blackLv3,
        thickness: 0.5,
        space: 36,
      ),
      appBarTheme: AppBarTheme(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        iconTheme: const IconThemeData(color: AppColors.blackLv1),
        backgroundColor: AppColors.white,
        elevation: 0.5,
        shadowColor: AppColors.blackLv3,
        titleTextStyle: AppTextStyle.bold(size: 18),
        titleSpacing: 0,
      ),
    );
  }

  // Dark Theme
  static ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: false,
      scaffoldBackgroundColor: AppColors.blackLv1,
      hintColor: AppColors.blackLv4,
      disabledColor: AppColors.blackLv4,
      fontFamily: AppTextStyle.defaultFontFamily,
      primaryColor: AppColors.primary,
      primarySwatch: AppColors.mainColor,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      iconTheme: const IconThemeData(color: AppColors.blackLv1),
      primaryIconTheme: const IconThemeData(color: AppColors.blackLv1),
      dividerTheme: const DividerThemeData(
        color: AppColors.blackLv3,
        thickness: 0.5,
        space: 36,
      ),
      appBarTheme: AppBarTheme(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        iconTheme: const IconThemeData(color: AppColors.blackLv1),
        backgroundColor: AppColors.white,
        elevation: 0.5,
        shadowColor: AppColors.blackLv3,
        titleTextStyle: AppTextStyle.bold(size: 18),
        titleSpacing: 0,
      ),
    );
  }

  // Scroll behaviour overridden
  static ScrollBehavior scrollBehavior(BuildContext context) {
    return ScrollConfiguration.of(context).copyWith(
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
    );
  }
}
