import 'package:weather/modules/weather/models/weather_model.dart';
import 'package:weather/modules/weather/repository/weather_repository.dart';

/// Интерактор взаимодействия с фактами
class WeatherInteractor {
  final WeatherRepository _weatherRepository;
  WeatherModel? weather;

  WeatherInteractor(this._weatherRepository);

  /// Получить список фактов
  Future<WeatherModel> getWeather(String city) async {
    final weather = await _weatherRepository.getWeather(city);
    return weather;
  }
}
