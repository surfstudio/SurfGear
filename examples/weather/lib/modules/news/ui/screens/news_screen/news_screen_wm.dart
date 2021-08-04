import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:weather/error_handlers/app_error_handler.dart';
import 'package:weather/modules/news/services/news_intearctor.dart';
import 'package:provider/provider.dart';

class NewsScreenWidgetModel extends WidgetModel {
  NewsScreenWidgetModel(
      WidgetModelDependencies baseDependencies, this._newsInteractor)
      : super(baseDependencies);

  /// интерактор с API новостей
  final NewsInteractor _newsInteractor;

  //TODO: убрать быстрый тест
  void testRequest() async {
    final r = await _newsInteractor.getNews(offset: 10, limit: 2, keywords: '');
    print(r);
  }
}

NewsScreenWidgetModel createNewsScreenWidgetModel(BuildContext context) {
  return NewsScreenWidgetModel(
    WidgetModelDependencies(
      errorHandler: AppErrorHandler(context: context),
    ),
    context.read<NewsInteractor>(),
  );
}
