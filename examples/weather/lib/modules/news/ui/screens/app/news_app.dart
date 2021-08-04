import 'package:flutter/material.dart';
import 'package:weather/modules/news/ui/screens/app/news_app_dependencies.dart';
import 'package:weather/modules/news/ui/screens/news_screen/news_screen.dart';

class NewsApp extends StatelessWidget {
  const NewsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NewsAppDependencies(
      app: NewsScreen(),
    );
  }
}
