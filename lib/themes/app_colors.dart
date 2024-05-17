import 'package:flutter/material.dart';

// App Colors
class AppColors {
  // This class is not meant to be instatiated or extended; this constructor
  // prevents instantiation and extension.
  AppColors._();

  // Main App Color
  static MaterialColor mainColor = createMaterialColor(primary);

  // Convert Color into MaterialColor
  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }

  // Native Colors
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color transparent = Colors.transparent;

  // Named Colors
  static const Color primary = blueLv1;
  static const Color secondary = darkBlueLv1;
  static const Color success = greenLv2;
  static const Color warning = yellowLv2;
  static const Color error = redLv2;
  static const Color disabled = blackLv5;

  // Black
  static const Color blackLv1 = Color(0xFF212121);
  static const Color blackLv2 = Color(0xFF424242);
  static const Color blackLv3 = Color(0xFF616161);
  static const Color blackLv4 = Color(0xFF757575);
  static const Color blackLv5 = Color(0xFF9E9E9E);
  static const Color blackLv6 = Color(0xFFBDBDBD);
  static const Color blackLv7 = Color(0xFFE0E0E0);
  static const Color blackLv8 = Color(0xFFEEEEEE);
  static const Color blackLv9 = Color(0xFFF5F5F5);
  static const Color blackLv10 = Color(0xFFFAFAFA);

  // Blue
  static const Color blueLv1 = Color(0xFF0056D2);
  static const Color blueLv2 = Color(0xFF3886E3);
  static const Color blueLv3 = Color(0xFF60A7F1);
  static const Color blueLv4 = Color(0xFF96CBFA);
  static const Color blueLv5 = Color(0xFFCAE7FC);
  static const Color blueLv6 = Color(0xFFEDF5FF);

  // Dark Blue
  static const Color darkBlueLv1 = Color(0xFF0F172A);
  static const Color darkBlueLv2 = Color(0xFF1E293B);
  static const Color darkBlueLv3 = Color(0xFF334155);
  static const Color darkBlueLv4 = Color(0xFF475569);
  static const Color darkBlueLv5 = Color(0xFFCBD5E1);
  static const Color darkBlueLv6 = Color(0xFFF1F5F9);

  // Yellow
  static const Color yellowLv1 = Color(0xFFD68B00);
  static const Color yellowLv2 = Color(0xFFF9AA00);
  static const Color yellowLv3 = Color(0xFFFFC341);
  static const Color yellowLv4 = Color(0xFFFFD579);
  static const Color yellowLv5 = Color(0xFFFFE6AF);
  static const Color yellowLv6 = Color(0xFFFFF2D5);

  // Green
  static const Color greenLv1 = Color(0xFF199226);
  static const Color greenLv2 = Color(0xFF48C54A);
  static const Color greenLv3 = Color(0xFF6DD16E);
  static const Color greenLv4 = Color(0xFF92E193);
  static const Color greenLv5 = Color(0xFFC5FBC6);
  static const Color greenLv6 = Color(0xFFE4FFE5);

  // Red
  static const Color redLv1 = Color(0xFFD12920);
  static const Color redLv2 = Color(0xFFF4462C);
  static const Color redLv3 = Color(0xFFF76F5A);
  static const Color redLv4 = Color(0xFFFF9F90);
  static const Color redLv5 = Color(0xFFFFC0B7);
  static const Color redLv6 = Color(0xFFFFE0DB);

  // Orange
  static const Color orangeLv1 = Color(0xFFFF832A);
  static const Color orangeLv2 = Color(0xFFFE964A);
  static const Color orangeLv3 = Color(0xFFFFAD73);
  static const Color orangeLv4 = Color(0xFFFFC8A0);
  static const Color orangeLv5 = Color(0xFFFFDCC3);
  static const Color orangeLv6 = Color(0xFFFFE8D8);

  // Purple
  static const Color purpleLv1 = Color(0xFF6D3AF9);
  static const Color purpleLv2 = Color(0xFF8C62FF);
  static const Color purpleLv3 = Color(0xFFA383FC);
  static const Color purpleLv4 = Color(0xFFBCA4FF);
  static const Color purpleLv5 = Color(0xFFD1C1FF);
  static const Color purpleLv6 = Color(0xFFE4DBFF);

  // Cyan
  static const Color cyanLv1 = Color(0xff00BCD3);
}
