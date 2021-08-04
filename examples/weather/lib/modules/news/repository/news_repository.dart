import 'dart:convert';

import 'package:weather/error_handlers/exceptions.dart';
import 'package:weather/modules/news/models/news.dart';
import 'package:weather/modules/news/repository/news_api_client.dart';

/// Репозиторий для работы с API MediaStack
class NewsRepository {
  final NewsApiClient client;

  const NewsRepository(this.client);

  /// Получить новостей по заданному в keywords городу
  Future<News> getNews(
      {required int offset,
      required int limit,
      required String keywords}) async {
    final Map<String, String> params = {
      'access_key': '7f0b11f47dc10002ac1008640cf786bd',
      'languages': 'en',
      'offset': offset.toString(),
      'limit': limit.toString(),
      'keywords': keywords,
    };

    final response = await client.get('/v1/news', params: params);
    if (response.statusCode == 200 && response.body.isNotEmpty) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;

      /// парсинг через сгенерированный fromJson
      return News.fromJson(data);
    } else {
      print(response.statusCode);
      if (response.statusCode == 400) {
        throw ClientNetworkException();
      } else if (response.statusCode >= 401 && response.statusCode <= 599) {
        throw ServerNetworkException();
      } else {
        throw Exception('Bad request with code:  ${response.statusCode}');
      }
    }
  }
}
