import 'package:location/location.dart';

import '../../utilities/console_log.dart';

class LocationService {
  // This class is not meant to be instatiated or extended; this constructor
  // prevents instantiation and extension.
  LocationService._();

  static Location location = Location();

  static LocationData? locationData;

  static bool _serviceEnabled = false;

  static PermissionStatus _permissionGranted = PermissionStatus.denied;

  static Future<LocationData?> getCurrentPosition({
    required Function onServiceDisabled,
    required Function onPermissionDenied,
  }) async {
    try {
      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          return onServiceDisabled();
        }
      }

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return onPermissionDenied();
        }
      }

      locationData = await location.getLocation();
      return locationData!;
    } catch (e) {
      cl('[getCurrentPosition].error $e');
      return null;
    }
  }
}
