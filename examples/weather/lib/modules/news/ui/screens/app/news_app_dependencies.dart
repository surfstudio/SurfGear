import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/modules/news/config/news_url_config.dart';
import 'package:weather/modules/news/repository/news_api_client.dart';
import 'package:weather/modules/news/repository/news_repository.dart';
import 'package:weather/modules/news/services/news_intearctor.dart';
import 'package:weather/modules/news/ui/screens/news_screen/news_screen.dart';

/// создание сервисного слоя, который будет получать новости по API
/// и прокидывание его в зависимости
class NewsAppDependencies extends StatelessWidget {
  final NewsScreen app;

  const NewsAppDependencies({required this.app, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final http = Client();
    final apiClient = NewsApiClient(NewsUrlConfig.baseUrl, http);
    final newsRepository = NewsRepository(apiClient);
    final newsInteractor = NewsInteractor(newsRepository);

    return MultiProvider(
      providers: [
        Provider<NewsInteractor>(create: (_) => newsInteractor),
      ],
      child: app,
    );
  }
}
