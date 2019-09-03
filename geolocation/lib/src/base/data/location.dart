import 'dart:math';

const double _EARTH_RADIUS = 6372795; //meters
/// A data class that contains various information about the user's location.
class Location {
  /// Latitude, in degrees
  final double latitude;

  /// Longitude, in degrees
  final double longitude;

  /// Estimated horizontal accuracy of this location, radial, in meters
  final double accuracy;

  /// In meters above the WGS 84 reference ellipsoid
  final double altitude;

  /// In meters/second
  final double speed;

  /// In meters/second
  final double speedAccuracy;

  ///Heading is the horizontal direction of travel of this device, in degrees
  final double heading;

  ///timestamp of the LocationData
  final DateTime time;

  const Location({
    this.latitude,
    this.longitude,
    this.accuracy,
    this.altitude,
    this.speed,
    this.speedAccuracy,
    this.heading,
    this.time,
  });

  //todo тесты и причесать
  double distanceTo(double x, double y) {
    double lat1 = latitude*pi/180;
    double lat2 = x *pi/180;
    double long1 = longitude*pi/180;
    double long2 = y *pi/180;

    //косинусы и синусы широт и разницы долгот | cos and sin of longitude/latitude
    double cl1 = cos(lat1);
    double cl2 = cos(lat2);
    double sl1 = sin(lat1);
    double sl2 = sin(lat2);
    double delta = long2 - long1;
    double cdelta = cos(delta);
    double sdelta = sin(delta);

    // вычисления длины большого круга | calculate  how long is big circle
    double yy = sqrt(pow(cl2*sdelta,2)+pow(cl1*sl2-sl1*cl2*cdelta,2));
    double xx = sl1*sl2+cl1*cl2*cdelta;
    double ad = atan2(yy,xx);
    double dist = ad*_EARTH_RADIUS;
    return dist;
  }
}

/// Precision of the Location
/// https://developers.google.com/android/reference/com/google/android/gms/location/LocationRequest
/// https://developer.apple.com/documentation/corelocation/cllocationaccuracy?language=objc
enum LocationAccuracy {
  // To request best accuracy possible with zero additional power consumption
  POWERSAVE,

  /// To request "city" level accuracy
  LOW,

  /// To request "block" level accuracy
  BALANCED,

  /// To request the most accurate locations available
  HIGH,

  /// To request location for navigation usage
  NAVIGATION
}
