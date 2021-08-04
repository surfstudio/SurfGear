import 'package:weather/modules/news/models/news.dart';
import 'package:weather/modules/news/repository/news_repository.dart';

/// Интерактор взаимодействия с новостями
class NewsInteractor {
  final NewsRepository _newsRepository;

  NewsInteractor(this._newsRepository);

  /// Получить погоду по выбранному городу
  Future<News> getNews({
    required int offset,
    required int limit,
    required String keywords,
  }) {
    return _newsRepository.getNews(
      offset: offset,
      limit: limit,
      keywords: keywords,
    );
  }
}
