import 'package:flutter/material.dart';
import 'package:push_demo/message_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final String appTitle = 'Push demo';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: MyHomePage(appTitle: appTitle),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String appTitle;

  MyHomePage({Key key, this.appTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
      ),
      body: MessageWidget(),
    );
  }
}
