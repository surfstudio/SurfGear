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
      routes: {
        Router.main: (_) => MainPage(),
        Router.catalog: (_) => CatalogPage(),
      },
    );
  }
}
