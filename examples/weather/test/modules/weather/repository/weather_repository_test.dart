import 'package:http/http.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather/modules/weather/repository/weather_api_client.dart';
import 'package:weather/modules/weather/repository/weather_repository.dart';

/// мок класс для тестирования
class WeatherApiClientMock extends Mock implements WeatherApiClient {}

/// тесты для [WeatherRepository]
void main() {
  /// late - так как будут настроены в setUp
  late WeatherApiClientMock weatherApiClientMock;
  late WeatherRepository weatherRepository;

  const Map<String, String> params = {
    'units': 'metric',
    'appid': 'f6c94efdd8a88e35fd00a12d8beab998',
    'q': 'Moscow',
  };

  const String weatherResp =
      '{"coord":{"lon":-0.1257,"lat":51.5085},"weather":[{"id":802,"main":"Clouds","description":"scattered clouds","icon":"03d"}],"base":"stations","main":{"temp":18.84,"feels_like":18.76,"temp_min":16.61,"temp_max":21.81,"pressure":1003,"humidity":76},"visibility":10000,"wind":{"speed":6.17,"deg":160},"clouds":{"all":40},"dt":1628175620,"sys":{"type":2,"id":268730,"country":"GB","sunrise":1628137828,"sunset":1628192550},"timezone":3600,"id":2643743,"name":"London","cod":200}';

  /// setUp вызывается перед каждым тестом, setUpAll - один раз перед всеми тестами
  setUp(() {
    weatherApiClientMock = WeatherApiClientMock();
    weatherRepository = WeatherRepository(weatherApiClientMock);
  });

  test(
    'getWeather should make correct API request',
    () {
      when(
        () => weatherApiClientMock.get(
          '/data/2.5/weather',
          params: params,
        ),
      ).thenAnswer(
        (invocation) => Future.value(
          //TODO: уточнить, как правильно. Невалидный JSON кидает ошибки.
          Response(weatherResp, 200),
        ),
      );

      weatherRepository.getWeather('Moscow');

      verify(() =>
              weatherApiClientMock.get('/data/2.5/weather', params: params))
          .called(1);
    },
  );
}
