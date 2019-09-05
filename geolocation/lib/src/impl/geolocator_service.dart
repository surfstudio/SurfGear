import 'package:flutter/services.dart';
import 'package:geolocation/src/base/data/location.dart';
import 'package:geolocation/src/base/exceptions.dart';
import 'package:geolocation/src/base/location_service.dart';
import 'package:geolocator/geolocator.dart' as lib;
import 'package:rxdart/rxdart.dart';

/// Based on https://github.com/BaseflowIT/flutter-geolocator
/// Additionaly can compute distance between two points
class GeolocatorService implements LocationService {
  final lib.LocationAccuracy accuracy;
  final int distanceFilter;
  final int interval;
  final Location defaultLocation;
  final bool shouldUseLocationManager;

  final lib.Geolocator _geolocator;

  GeolocatorService({
    LocationAccuracy accuracy = LocationAccuracy.HIGH,
    this.interval = 1000,
    this.distanceFilter = 0,
    this.defaultLocation,
    this.shouldUseLocationManager = false,
  })  : this.accuracy = _mapAccuracy(accuracy),
        _geolocator = lib.Geolocator()
          ..forceAndroidLocationManager = shouldUseLocationManager;

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
        .then(_positionToLocation, onError: (e) => getLastKnownLocation())
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
  Observable<Location> observeLocation() {
    final options = lib.LocationOptions(
      accuracy: accuracy,
      distanceFilter: distanceFilter,
      timeInterval: interval,
      forceAndroidLocationManager: shouldUseLocationManager,
    );

    return Observable(_geolocator.getPositionStream(options))
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

  Future<Location> _handleError(error, stacktrace) {
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
      case LocationAccuracy.POWERSAVE:
        return lib.LocationAccuracy.lowest;
        break;
      case LocationAccuracy.LOW:
        return lib.LocationAccuracy.low;
        break;
      case LocationAccuracy.BALANCED:
        return lib.LocationAccuracy.medium;
        break;
      case LocationAccuracy.HIGH:
        return lib.LocationAccuracy.best;
        break;
      case LocationAccuracy.NAVIGATION:
        return lib.LocationAccuracy.bestForNavigation;
        break;
      default:
        return lib.LocationAccuracy.best;
    }
  }
}
