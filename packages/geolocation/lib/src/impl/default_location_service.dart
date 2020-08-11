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

import 'package:geolocation/src/base/data/location.dart';
import 'package:geolocation/src/base/exceptions.dart';
import 'package:geolocation/src/base/location_service.dart';
import 'package:location/location.dart' as lib;

/// Location service implementation.
/// Based on https://pub.dev/packages/location
class DefaultLocationService implements LocationService {
  DefaultLocationService({
    LocationAccuracy accuracy = LocationAccuracy.high,
    int interval = 1000,
    double distanceFilter = 0,
  }) {
    _locationService.changeSettings(
      accuracy: _mapAccuracy(accuracy),
      interval: interval,
      distanceFilter: distanceFilter,
    );
  }

  final _locationService = lib.Location();

  @override
  Future<Location> getLocation() => _checkStatus()
      .then((_) => _locationService.getLocation())
      .then(_locationDataToLocation);

  @override
  Future<Location> getLastKnownLocation() {
    return getLocation();
  }

  @override
  Future<bool> hasPermission() async {
    final status = await _locationService.hasPermission();
    return status == lib.PermissionStatus.GRANTED;
  }

  @override
  Stream<Location> observeLocation() => _checkStatus()
      .asStream()
      .asyncExpand((_) => _locationService.onLocationChanged())
      .map(_locationDataToLocation);

  @override
  Future<bool> isLocationServiceEnabled() {
    return _locationService.serviceEnabled();
  }

  Future<void> _checkStatus() async {
    final serviceEnabled = await _locationService.requestService();
    final hasPermission = await _locationService.requestPermission();

    if (!serviceEnabled) {
      throw LocationServiceNotAvailableException();
    }

    if (hasPermission != lib.PermissionStatus.GRANTED) {
      throw LocationPermissionNotGrantedException();
    }
  }

  Location _locationDataToLocation(lib.LocationData data) {
    return Location(
      latitude: data.latitude,
      longitude: data.longitude,
      accuracy: data.accuracy,
      altitude: data.altitude,
      speed: data.speed,
      speedAccuracy: data.speedAccuracy,
      heading: data.heading,
      time: DateTime.fromMillisecondsSinceEpoch(data.time.toInt()),
    );
  }

  lib.LocationAccuracy _mapAccuracy(LocationAccuracy source) {
    switch (source) {
      case LocationAccuracy.powerSave:
        return lib.LocationAccuracy.POWERSAVE;
        break;
      case LocationAccuracy.low:
        return lib.LocationAccuracy.LOW;
        break;
      case LocationAccuracy.balanced:
        return lib.LocationAccuracy.BALANCED;
        break;
      case LocationAccuracy.high:
        return lib.LocationAccuracy.HIGH;
        break;
      case LocationAccuracy.navigator:
        return lib.LocationAccuracy.NAVIGATION;
        break;
      default:
        return lib.LocationAccuracy.HIGH;
    }
  }
}
