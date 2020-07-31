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

import 'package:flutter/services.dart';
import 'package:geolocation/src/base/data/location.dart';
import 'package:geolocation/src/base/exceptions.dart';
import 'package:geolocation/src/base/location_service.dart';
import 'package:geolocator/geolocator.dart' as lib;
import 'package:rxdart/rxdart.dart';

/// Based on https://github.com/BaseflowIT/flutter-geolocator
/// Additionally can compute distance between two points
class GeolocatorService implements LocationService {
  GeolocatorService({
    LocationAccuracy accuracy = LocationAccuracy.high,
    this.interval = 1000,
    this.distanceFilter = 0,
    this.defaultLocation,
    this.shouldUseLocationManager = false,
  })  : accuracy = _mapAccuracy(accuracy),
        _geolocator = lib.Geolocator()
          ..forceAndroidLocationManager = shouldUseLocationManager;

  final lib.LocationAccuracy accuracy;
  final int distanceFilter;
  final int interval;
  final Location defaultLocation;
  final bool shouldUseLocationManager;

  final lib.Geolocator _geolocator;

  /// Returns the distance between the supplied coordinates in meters.
  Future<double> distanceBetween(
    double startLatitude,
    double startLongitude,
    double endLatitude,
    double endLongitude,
  ) {
    return lib.Geolocator().distanceBetween(
        startLatitude, startLongitude, endLatitude, endLongitude);
  }

  @override
  Future<Location> getLocation() {
    return _geolocator
        .getCurrentPosition(desiredAccuracy: accuracy)
        .then(_positionToLocation,
            // ignore: avoid_types_on_closure_parameters
            onError: (Exception e) => getLastKnownLocation())
        .catchError(_handleError);
  }

  @override
  Future<Location> getLastKnownLocation() {
    return _geolocator
        .getLastKnownPosition(desiredAccuracy: accuracy)
        .then(_positionToLocation)
        .catchError(_handleError);
  }

  @override
  Future<bool> hasPermission() {
    return _geolocator
        .checkGeolocationPermissionStatus()
        .then((status) => status == lib.GeolocationStatus.granted);
  }

  @override
  Stream<Location> observeLocation() {
    final options = lib.LocationOptions(
      accuracy: accuracy,
      distanceFilter: distanceFilter,
      timeInterval: interval,
      forceAndroidLocationManager: shouldUseLocationManager,
    );

    return _geolocator
        .getPositionStream(options)
        .map(_positionToLocation)
        .doOnError(_handleError);
  }

  @override
  Future<bool> isLocationServiceEnabled() {
    return _geolocator
        .checkGeolocationPermissionStatus()
        .then((status) => status != lib.GeolocationStatus.disabled);
  }

  Location _positionToLocation(lib.Position position) {
    return Location(
      latitude: position.latitude,
      longitude: position.longitude,
      accuracy: position.accuracy,
      altitude: position.altitude,
      heading: position.heading,
      speed: position.speed,
      speedAccuracy: position.speedAccuracy,
      time: position.timestamp,
    );
  }

  Future<Location> _handleError(Exception error, String stacktrace) {
    if (error is PlatformException) {
      throw LocationPermissionNotGrantedException();
    }

    if (defaultLocation == null) {
      throw LocationNotAvailableException();
    }

    return Future.value(defaultLocation);
  }

  static lib.LocationAccuracy _mapAccuracy(LocationAccuracy source) {
    switch (source) {
      case LocationAccuracy.powerSave:
        return lib.LocationAccuracy.lowest;
        break;
      case LocationAccuracy.low:
        return lib.LocationAccuracy.low;
        break;
      case LocationAccuracy.balanced:
        return lib.LocationAccuracy.medium;
        break;
      case LocationAccuracy.high:
        return lib.LocationAccuracy.best;
        break;
      case LocationAccuracy.navigator:
        return lib.LocationAccuracy.bestForNavigation;
        break;
      default:
        return lib.LocationAccuracy.best;
    }
  }
}
