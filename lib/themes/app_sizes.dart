// App Sizes

import 'dart:ui';

class AppSizes {
  // This class is not meant to be instatiated or extended; this constructor
  // prevents instantiation and extension.
  AppSizes._();

  static Size screenSize = (PlatformDispatcher.instance.implicitView?.physicalSize ?? const Size(0, 0)) /
      PlatformDispatcher.instance.views.first.devicePixelRatio;

  static const double padding = 18;
  static const double radius = 8;
}
