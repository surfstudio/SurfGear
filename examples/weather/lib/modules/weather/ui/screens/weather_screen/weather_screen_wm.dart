import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mwwm/mwwm.dart';
import 'package:relation/relation.dart';
import 'package:weather/modules/weather/models/weather.dart';
import 'package:weather/modules/weather/services/weather_interactor.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:relation/relation.dart' as relation show TextEditingAction;

class WeatherScreenWidgetModel extends WidgetModel {
  WeatherScreenWidgetModel(
      WidgetModelDependencies baseDependencies, this._weatherInteractor)
      : super(baseDependencies);

  final WeatherInteractor _weatherInteractor;

  /// Данные для экрана
  final weathertState = EntityStreamedState<Weather>()
    ..loading(); // перевод в загрузку на старте

  /// Действие - получить данные по введённому городу
  final fetchInput = VoidAction();

  /// Экшен - получение города
  /// получение значения - через cityInputAction.controller.value.text
  final cityInputAction = relation.TextEditingAction();

  /// --------------------

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
    /// подписка на стрим событий с кнопки "погода по городу" на запрос погоды по нему
    subscribe(fetchInput.stream, _getWeatherInfoT);
    super.onBind();
  }

  void _getWeatherInfoT(_) {
    _weatherInteractor
        .getWeather(cityInputAction.controller.value.text)
        .then((value) => weathertState.content(value))
        .catchError((e) => weathertState.error(e));
  }

  void _getWeatherInfo(_) async {
    final newWeather = await _weatherInteractor
        .getWeather(cityInputAction.controller.value.text);
    weathertState.content(newWeather);
    print(newWeather);
  }
}

WeatherScreenWidgetModel createWeatherScreenWidgetModel(BuildContext context) {
  return WeatherScreenWidgetModel(
    const WidgetModelDependencies(),
    context.read<WeatherInteractor>(),
  );
}
