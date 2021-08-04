import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:weather/modules/news/ui/screens/news_screen/news_screen_wm.dart';

/// основной экран новостей
class NewsScreen extends CoreMwwmWidget<NewsScreenWidgetModel> {
  NewsScreen({Key? key})
      : super(
          key: key,
          widgetModelBuilder: (context) => createNewsScreenWidgetModel(context),
        );

  @override
  WidgetState<CoreMwwmWidget<NewsScreenWidgetModel>, NewsScreenWidgetModel>
      createWidgetState() {
    return _NewsScreen();
  }
}

class _NewsScreen extends WidgetState<NewsScreen, NewsScreenWidgetModel> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text('yo tho'),
          onPressed: wm.testRequest,
        ),
      ),
    );
  }
}
