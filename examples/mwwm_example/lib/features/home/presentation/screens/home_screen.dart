import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:mwwm_example/features/home/domain/entities/home_data.dart';
import 'package:mwwm_example/features/home/presentation/wms/home_screen_wm.dart';

class HomeScreen extends CoreMwwmWidget<HomeScreenWidgetModel> {
  const HomeScreen({Key? key})
      : super(
          key: key,
          widgetModelBuilder: homeScreenWidgetModelBuilder,
        );

  @override
  WidgetState<CoreMwwmWidget<HomeScreenWidgetModel>, HomeScreenWidgetModel>
      createWidgetState() => _HomeScreenState();
}

class _HomeScreenState extends WidgetState<HomeScreen, HomeScreenWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home page'),
      ),
      body: FutureBuilder(
        future: wm.getData(),
        builder: (
          context,
          snapshot,
        ) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          final data = snapshot.data as HomeData;
          return ListView.builder(
            itemCount: data.posts.length,
            itemExtent: 100,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  const Text('Title'),
                  Text(data.posts[index].title),
                  const Text('Description'),
                  Text(data.posts[index].description),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
