import 'dart:convert';

import 'package:weather/error_handlers/exceptions.dart';
import 'package:weather/modules/news/repository/news_api_client.dart';
import 'package:weather/modules/weather/models/weather.dart';

/// Репозиторий для работы с API Mediastack
class NewsRepository {
  final NewsApiClient client;

  const NewsRepository(this.client);

  /// Получить прогноз погоды по заданному городу

}
