import 'package:flutter/material.dart';
import 'package:surfgear_webpage/assets/text.dart';
import 'package:surfgear_webpage/pages/catalog/catalog_page.dart';
import 'package:surfgear_webpage/pages/main/main_page.dart';

void main() {
  runApp(MyApp());
}

abstract class Router {
  static const main = '/';
  static const catalog = '/catalog';

  static final map = <String, Widget>{
    main: MainPage(),
    catalog: CatalogPage(),
  };
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: titleText,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: Router.main,
      onGenerateRoute: (settings) {
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => Router.map[settings.name],
        );
      },
    );
  }
}
