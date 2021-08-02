import 'dart:convert';

import 'package:weather/modules/weather/models/weather_model.dart';
import 'package:weather/modules/weather/repository/weather_api_client.dart';

/// Репозиторий для работы с API OpneWeatherMap
class WeatherRepository {
  final WeatherApiClient client;

  const WeatherRepository(this.client);

  /// Получить прогноз погоды по заданному городу
  Future<WeatherModel> getWeather(String city) async {
    final Map<String, String> params = {
      'units': 'metric',
      'appid': 'f6c94efdd8a88e35fd00a12d8beab998',
      'q': city,
    };

    final response = await client.get('/data/2.5/weather', params: params);
    if (response.statusCode == 200 && response.body.isNotEmpty) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;

      /// парсинг через сгенерированный fromJson
      return WeatherModel.fromJson(data);
    } else {
      throw Exception('Bad request with code:  ${response.statusCode}');
    }
  }
}
