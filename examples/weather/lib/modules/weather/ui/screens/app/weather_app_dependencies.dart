import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/modules/weather/config/url_config.dart';
import 'package:weather/modules/weather/repository/weather_api_client.dart';
import 'package:weather/modules/weather/repository/weather_repository.dart';
import 'package:weather/modules/weather/services/weather_interactor.dart';
import 'package:http/http.dart';
import 'package:weather/modules/weather/ui/screens/weather_screen/weather_screen.dart';

/// создание сервисного слоя, который будет получать погоду по API и прокидывание его в зависимости
class WeatherAppDependencies extends StatelessWidget {
  final WeatherScreen app;

  const WeatherAppDependencies({required this.app, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final http = Client();
    final apiClient = WeatherApiClient(UrlConfig.baseUrl, http);
    final weatherRepository = WeatherRepository(apiClient);
    final weatherInteractor = WeatherInteractor(weatherRepository);

    return MultiProvider(
      providers: [
        Provider<WeatherInteractor>(create: (_) => weatherInteractor),
      ],
      child: app,
    );
  }
}
