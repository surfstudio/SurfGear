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
