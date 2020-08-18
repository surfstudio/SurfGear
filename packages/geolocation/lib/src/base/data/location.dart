// Copyright (c) 2019-present,  SurfStudio LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'dart:math';

const double _earthRadius = 6372795; //meters

/// A data class that contains various information about the user's location.
class Location {
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

  //todo тесты и причесать
  double distanceTo(double x, double y) {
    final double lat1 = latitude * pi / 180;
    final double lat2 = x * pi / 180;
    final double long1 = longitude * pi / 180;
    final double long2 = y * pi / 180;

    //косинусы и синусы широт и разницы долгот | cos and sin of longitude/latitude
    final double cl1 = cos(lat1);
    final double cl2 = cos(lat2);
    final double sl1 = sin(lat1);
    final double sl2 = sin(lat2);
    final double delta = long2 - long1;
    final double cdelta = cos(delta);
    final double sdelta = sin(delta);

    // вычисления длины большого круга | calculate  how long is big circle
    final double yy =
        sqrt(pow(cl2 * sdelta, 2) + pow(cl1 * sl2 - sl1 * cl2 * cdelta, 2));
    final double xx = sl1 * sl2 + cl1 * cl2 * cdelta;
    final double ad = atan2(yy, xx);
    final double dist = ad * _earthRadius;
    return dist;
  }
}

/// Precision of the Location
/// https://developers.google.com/android/reference/com/google/android/gms/location/LocationRequest
/// https://developer.apple.com/documentation/corelocation/cllocationaccuracy?language=objc
enum LocationAccuracy {
  // To request best accuracy possible with zero additional power consumption
  powerSave,

  /// To request "city" level accuracy
  low,

  /// To request "block" level accuracy
  balanced,

  /// To request the most accurate locations available
  high,

  /// To request location for navigation usage
  navigator
}
