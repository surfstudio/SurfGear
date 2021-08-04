import 'package:flutter/cupertino.dart';
import 'package:mwwm/mwwm.dart';
import 'package:relation/relation.dart';
import 'package:weather/domain/city_model.dart';
import 'package:weather/modules/weather/models/weather_model.dart';
import 'package:weather/modules/weather/services/weather_interactor.dart';
import 'package:provider/provider.dart';

class WeatherScreenWidgetModel extends WidgetModel {
  WeatherScreenWidgetModel(
      WidgetModelDependencies baseDependencies, this._weatherInteractor)
      : super(baseDependencies);

  final WeatherInteractor _weatherInteractor;

  /// Данные для экрана
  final contentState = EntityStreamedState<WeatherModel>()..loading();

  /// Данные - город пользователя
  final cityInfo = EntityStreamedState<cityModel>();

  /// Получить данные по введённому городу
  final fetchInput = VoidAction();

  /// Найти город исходя из текущео гео пользователя
  final findCityByGeo = VoidAction();

  /// Перезагрузить экран в случае ошибки
  final reloadErrorAction = VoidAction();

  @override
  void onLoad() {
    super.onLoad();
  }

  @override
  void onBind() {
    // TODO: сделать подписку на сервисы
    super.onBind();
  }

  // TODO: быстрый тест, убрать
  WeatherModel? currentWeather;

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
