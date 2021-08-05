import 'package:flutter/cupertino.dart';
import 'package:mwwm/mwwm.dart';
import 'package:relation/relation.dart';
import 'package:weather/error_handlers/app_error_handler.dart';
import 'package:weather/modules/app/services/app_storage_interactor.dart';
import 'package:weather/modules/news/ui/screens/app/news_screen_route.dart';
import 'package:weather/modules/weather/models/weather.dart';
import 'package:weather/modules/weather/services/find_lication.dart';
import 'package:weather/modules/weather/services/weather_interactor.dart';
import 'package:provider/provider.dart';
import 'package:relation/relation.dart' as relation show TextEditingAction;

class WeatherScreenWidgetModel extends WidgetModel {
  WeatherScreenWidgetModel(WidgetModelDependencies baseDependencies,
      this._weatherInteractor, this._appStorageInteractor)
      : super(baseDependencies);

  /// интерактор с сервисным слоем погоды
  final WeatherInteractor _weatherInteractor;

  /// интерактор с сервисным слоем хранилища приложения
  final AppStorageInteractor _appStorageInteractor;

  /// Данные для экрана.
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

  final geoService = GeoService();

  /// Установка нового бекграунда
  void _setBackround(String newBackground) {
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
    subscribe(fetchInput.stream, _getWeatherInfo);

    /// подписка на стрим событий с кнопки "погода в моеё локации"
    subscribe(findCityByGeo.stream, _getWeatherInfoCoords);

    /// инициализация - запрос погоды из текущих координат при старте приложения
    _getWeatherInfoCoords(null);
    super.onBind();
  }

  /// отправка погоды в weathertState из окна ввода через try - catch
  void _getWeatherInfo(_) async {
    weathertState.loading();
    try {
      final newWeather = await _weatherInteractor
          .getWeather(cityInputAction.controller.value.text);
      weathertState.content(newWeather);

      /// установить фон согласно погоде
      _setBackround(newWeather.weather[0].main);

      /// закинуть город в хранилище приложения
      _appStorageInteractor.city = newWeather.name;
    } catch (e, _) {
      /// обработать ошибку
      handleError(e);

      /// закинуть ошибку в стрим событий weatherState
      weathertState.error(Exception(e));
    }
  }

  /// отправка погоды в weatherState из текущих координат по try-catch
  void _getWeatherInfoCoords(_) async {
    weathertState.loading();
    try {
      final location = await geoService.findLoacation();
      final newWeather = await _weatherInteractor.getWeatherGeolocation(
          location.latitude ?? 0, location.longitude ?? 0);
      weathertState.content(newWeather);

      /// установить фон согласно погоде
      _setBackround(newWeather.weather[0].main);

      /// закинуть город в хранилище приложения
      _appStorageInteractor.city = newWeather.name;
    } catch (e, _) {
      /// обработать ошибку
      handleError(e);

      /// закинуть ошибку в стрим событий weatherState
      weathertState.error(Exception(e));
    }
  }

  /// открыть экран новостей через его Route
  void openNewsScreen(BuildContext context) {
    Navigator.push(
      context,
      NewsAppRoute(),
    );
  }
}

WeatherScreenWidgetModel createWeatherScreenWidgetModel(BuildContext context) {
  return WeatherScreenWidgetModel(
    /// добавлен обработчик ошибок
    WidgetModelDependencies(
      errorHandler: AppErrorHandler(context: context),
    ),
    context.read<WeatherInteractor>(),
    context.read<AppStorageInteractor>(),
  );
}
