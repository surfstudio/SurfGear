import 'package:flutter/material.dart';
import 'package:weather/modules/news/ui/screens/app/news_app.dart';

/// Роут для [NewsApp]
class NewsAppRoute extends MaterialPageRoute {
  NewsAppRoute()
      : super(
          builder: (context) => NewsApp(),
        );
}
