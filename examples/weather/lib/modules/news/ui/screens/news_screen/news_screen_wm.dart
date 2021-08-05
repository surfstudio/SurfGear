import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:weather/error_handlers/app_error_handler.dart';
import 'package:weather/modules/app/services/app_storage_interactor.dart';
import 'package:weather/modules/news/services/news_intearctor.dart';
import 'package:provider/provider.dart';

class NewsScreenWidgetModel extends WidgetModel {
  NewsScreenWidgetModel(WidgetModelDependencies baseDependencies,
      this._newsInteractor, this._appStorageInteractor)
      : super(baseDependencies) {
    _currentCity = _appStorageInteractor.getCity;
  }

  /// интерактор с API новостей
  final NewsInteractor _newsInteractor;

  /// интерактор с хранилищем приложения
  final AppStorageInteractor _appStorageInteractor;

  /// текущий город
  late final String _currentCity;

  /// получить текущий город
  String get currentCity => _currentCity;

  //TODO: убрать быстрый тест
  void testRequest() async {
    print(_currentCity);
    final r = await _newsInteractor.getNews(
        offset: 10, limit: 2, keywords: 'Pasadena');
    print(r);
  }
}

NewsScreenWidgetModel createNewsScreenWidgetModel(BuildContext context) {
  return NewsScreenWidgetModel(
    WidgetModelDependencies(
      errorHandler: AppErrorHandler(context: context),
    ),
    context.read<NewsInteractor>(),
    context.read<AppStorageInteractor>(),
  );
}
