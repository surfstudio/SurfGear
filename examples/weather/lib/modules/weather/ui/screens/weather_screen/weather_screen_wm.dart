import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mwwm/mwwm.dart';
import 'package:relation/relation.dart';
import 'package:weather/modules/weather/models/weather.dart';
import 'package:weather/modules/weather/services/weather_interactor.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:relation/relation.dart' as relation show TextEditingAction;
import 'package:weather/modules/weather/ui/res/assets.dart';

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

  /// Найти город исходя из текущео гео пользователя
  final findCityByGeo = VoidAction();

  /// стрим бекграундов
  final backgroundsState = StreamedState<String>("clouds");

  /// Установка нового бекграунда
  void setBackround(String newBackground) {
    if (['clear', 'clouds', 'mist', 'rain', 'snow', 'thunderstorm']
        .contains(newBackground.toLowerCase())) {
      backgroundsState.accept(newBackground.toLowerCase());
    } else {
      backgroundsState.accept('clouds');
    }
  }

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

  /// отправка погоды в weathertState через then и catchError
  void _getWeatherInfoT(_) {
    _weatherInteractor
        .getWeather(cityInputAction.controller.value.text)
        .then((value) => weathertState.content(value))
        .catchError((e) => weathertState.error(e));
  }

  /// отправка погоды в weathertState через try - catch
  void _getWeatherInfoA(_) async {
    try {
      final newWeather = await _weatherInteractor
          .getWeather(cityInputAction.controller.value.text);
      weathertState.content(newWeather);
      setBackround(newWeather.weather[0].main);
    } catch (e, stack) {
      weathertState.error(Exception(e));
    }
  }
}

WeatherScreenWidgetModel createWeatherScreenWidgetModel(BuildContext context) {
  return WeatherScreenWidgetModel(
    const WidgetModelDependencies(),
    context.read<WeatherInteractor>(),
  );
}
