import 'package:flutter/cupertino.dart';
import 'package:mwwm/mwwm.dart';
import 'package:relation/relation.dart';
import 'package:weather/domain/city_model.dart';
import 'package:weather/modules/weather/models/weather.dart';
import 'package:weather/modules/weather/services/weather_interactor.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class WeatherScreenWidgetModel extends WidgetModel {
  WeatherScreenWidgetModel(
      WidgetModelDependencies baseDependencies, this._weatherInteractor)
      : super(baseDependencies);

  final WeatherInteractor _weatherInteractor;

  /// Данные для экрана
  final weathertState = EntityStreamedState<
      Weather>(); //..loading(); - перевод в загрузкуна старте

  //TODO streamedAction
  /// Данные - город пользователя
  final cityInfo = EntityStreamedState<cityModel>();

  /// Получить данные по введённому городу
  final fetchInput = VoidAction();

  /// Найти город исходя из текущео гео пользователя
  final findCityByGeo = VoidAction();

  /// Перезагрузить экран в случае ошибки
  final reloadErrorAction = VoidAction();

  //TODO rxdart - zip (комбинирует 2 события)

  /// Текущий город
  String? _currentCity;

  /// Установить город
  void setCity(String newCity) => _currentCity = newCity;

  /// Получить текущий город
  String get currentCity => _currentCity ?? '';

  @override
  void onLoad() {
    super.onLoad();
  }

  @override
  void onBind() {
    /// подписка на стрим событий с кнопки "погода по городу" на запрос погоды по нему
    subscribe(fetchInput.stream, _getWeatherInfoA);
    super.onBind();
  }

  void _getWeatherInfoA(_) async {
    currentWeather = await _weatherInteractor.getWeather(currentCity);
    await getWeather;
  }

  void _getWeatherInfo(_) {
    _weatherInteractor
        .getWeather(_currentCity ?? "")
        .then((value) => weathertState.content(value))
        .catchError((e) => weathertState.error(e));
  }

  Weather? currentWeather;

  // TODO: быстрый тест, убрать
  void getWeather(String city) async {
    currentWeather = await _weatherInteractor.getWeather(city);
    print(currentWeather);
  }
}

WeatherScreenWidgetModel createWeatherScreenWidgetModel(BuildContext context) {
  return WeatherScreenWidgetModel(
    const WidgetModelDependencies(),
    context.read<WeatherInteractor>(),
  );
}
