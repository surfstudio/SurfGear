import 'package:flutter/material.dart';
import 'package:surfgear_webpage/webpage/webpage_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Surfgear template',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: WebpageWidget(),
      debugShowCheckedModeBanner: true,
    );
  }
}
