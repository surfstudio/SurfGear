import 'package:geolocation/src/base/data/location.dart';
import 'package:rxdart/rxdart.dart';

/// Service for location handling.
///
/// All settings required for getting location are implementors' responsibility.
abstract class LocationService {
  /// Gets the current location of the user.
  ///
  /// The decision about throwing an error if the app has no permission to access location
  /// delegated to implementors.
  Future<Location> getLocation();

  /// Gets the last known location of the user.
  ///
  /// The decision about throwing an error if the app has no permission to access location
  /// delegated to implementors.
  Future<Location> getLastKnownLocation();

  /// Checks if the app has permission to access location.
  Future<bool> hasPermission();

  /// Checks if the location service is enabled
  Future<bool> isLocationServiceEnabled();

  /// Returns a stream of location information.
  Observable<Location> observeLocation();
}
