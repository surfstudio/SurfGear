import 'package:location/location.dart';
import 'package:weather/error_handlers/exceptions.dart';

/// Класс сервисов, связанных с геопозицией устройства

class GeoService {
  /// Определяет текущее положение. Кидает ошибки при отсутствии геосервиса и разрещений
  /// В Web работает из коробки. На Андроиде и iOS требуются разрешения по пакету location
  Future<LocationData> findLoacation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        throw Exception('Geo service is not enabled');
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        throw Exception('Geo permission is not granted');
      }
    }

    /// перехват ошибки платформы
    try {
      _locationData = await location.getLocation();
    } catch (e) {
      throw GeolocationException();
    }

    return _locationData;
  }
}
