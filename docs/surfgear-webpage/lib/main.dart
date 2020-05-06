import 'package:flutter/material.dart';
import 'package:surfgear_webpage/assets/text.dart';
import 'package:surfgear_webpage/catalog/catalog.dart';
import 'package:surfgear_webpage/webpage/webpage_widget.dart';

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
        Router.main: (_) => WebpageWidget(),
        Router.catalog: (_) => Catalog(),
      },
    );
  }
}
