import 'package:flutter/cupertino.dart';

import 'package:mwwm/mwwm.dart';
import 'package:relation/relation.dart';
import 'package:weather/error_handlers/app_error_handler.dart';
import 'package:weather/modules/weather/models/weather.dart';
import 'package:weather/modules/weather/services/find_lication.dart';
import 'package:weather/modules/weather/services/weather_interactor.dart';
import 'package:provider/provider.dart';

import 'package:relation/relation.dart' as relation show TextEditingAction;

class WeatherScreenWidgetModel extends WidgetModel {
  WeatherScreenWidgetModel(
      WidgetModelDependencies baseDependencies, this._weatherInteractor)
      : super(baseDependencies);

  /// интерактор
  final WeatherInteractor _weatherInteractor;

  /// Данные для экрана
  final weathertState = EntityStreamedState<Weather>()
    ..loading(); // перевод в загрузку на старте

  /// Действие - получить данные по введённому городу
  final fetchInput = VoidAction();

  /// Экшен - получение города из поля ввода
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
    subscribe(findCityByGeo.stream, _getWeatherInfoCoords);
    super.onBind();
  }

  /// отправка погоды в weathertState через then и catchError
  // void _getWeatherInfoT(_) {
  //   _weatherInteractor
  //       .getWeather(cityInputAction.controller.value.text)
  //       .then((value) => weathertState.content(value))
  //       .catchError((e) => weathertState.error(e));
  // }

  /// отправка погоды в weathertState через try - catch
  void _getWeatherInfoA(_) async {
    try {
      final newWeather = await _weatherInteractor
          .getWeather(cityInputAction.controller.value.text);
      weathertState.content(newWeather);
      setBackround(newWeather.weather[0].main);
    } catch (e, _) {
      /// обработать ошибку
      handleError(e);

      /// закинуть ошибку в стрим
      weathertState.error(Exception(e));
    }
  }

  /// отправка погоды в weatherState из текущих координат по try-catch
  void _getWeatherInfoCoords(_) async {
    try {
      final location = await findLoacation();
      final newWeather = await _weatherInteractor.getWeatherGeolocation(
          location.latitude ?? 0, location.longitude ?? 0);
      weathertState.content(newWeather);
      setBackround(newWeather.weather[0].main);
    } catch (e, _) {
      handleError(e);
      weathertState.error(Exception(e));
    }
  }
}

WeatherScreenWidgetModel createWeatherScreenWidgetModel(BuildContext context) {
  return WeatherScreenWidgetModel(
    /// добавлен обработчик ошибок
    WidgetModelDependencies(errorHandler: AppErrorHandler()),
    context.read<WeatherInteractor>(),
  );
}

//TODO; вопросы на обсуждение:
// что должен делать обработчик ошибок
// как закинуть в него контекст, чтобы показать например снекбар

