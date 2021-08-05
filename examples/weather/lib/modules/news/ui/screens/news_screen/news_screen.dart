import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:weather/modules/news/ui/screens/news_screen/news_screen_wm.dart';
import 'package:weather/modules/news/ui/screens/news_screen/widgets/news_card.dart';
import 'package:weather/modules/weather/ui/res/ui_constants.dart';

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
      appBar: AppBar(
        title: Text('News about ${wm.currentCity}'),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            /// управление полем вовода и разделителе на больших экранах
            double columnPadding = standardPadding * 2;
            final width = constraints.maxWidth;
            if (width > maxColumnWidth + standardPadding * 2) {
              columnPadding = (width - maxColumnWidth) / 2;
            }

            return Container(
              padding: EdgeInsets.fromLTRB(columnPadding, standardPadding,
                  columnPadding, standardPadding),
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ElevatedButton(
                                child: Text("yo tho"),
                                onPressed: () {
                                  wm.testRequest();
                                },
                              ),
                              for (var i = 0; i < 50; i++) NewsCard(),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
