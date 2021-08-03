import 'package:weather/modules/weather/models/weather.dart';
import 'package:weather/modules/weather/repository/weather_repository.dart';

/// Интерактор взаимодействия с погодой
class WeatherInteractor {
  final WeatherRepository _weatherRepository;

  WeatherInteractor(this._weatherRepository);

  /// Получить погоду по выбранному городу
  Future<Weather> getWeather(String city) {
    return _weatherRepository.getWeather(city);
  }
}
