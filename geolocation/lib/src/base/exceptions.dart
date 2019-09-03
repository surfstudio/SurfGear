/// User hasn't granted access to location
class LocationPermissionNotGrantedException implements Exception {}

/// Location function doesn't exist or is disabled
class LocationServiceNotAvailableException implements Exception {}

/// App can not receive current or last known location
class LocationNotAvailableException implements Exception {
  @override
  String toString() {
    return "LocationNotAvailableException: App can not receive current or last known location and defaultLocation == null";
  }
}

class UserNeverWantToSeeDialogException implements Exception {
  @override
  String toString() {
    return "UserNeverWantToSeeDialogException: user say \" don't show again\"";
  }
}