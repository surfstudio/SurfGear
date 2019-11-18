import 'dart:async';
import 'dart:math';

import 'package:bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final StreamController<BottomNavTabType> _selectorController =
      StreamController<BottomNavTabType>();

  List<BottomNavTabType> _types = [
    BottomNavTabType(0),
    BottomNavTabType(1),
    BottomNavTabType(2),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: BottomNavigator(
          initialTab: _types[0],
          map: {
            _types[0]: BottomNavigationRelationship(
              () => _buildPage(Color(0xFFFF0000)),
              (isSelected) => _buildElement(
                isSelected,
                Color(0x55FF0000),
              ),
            ),
            _types[1]: BottomNavigationRelationship(
                  () => _buildPage(Color(0xFF00FF00)),
                  (isSelected) => _buildElement(
                isSelected,
                Color(0x5500FF00),
              ),
            ),
            _types[2]: BottomNavigationRelationship(
                  () => _buildPage(Color(0xFF0000FF)),
                  (isSelected) => _buildElement(
                isSelected,
                Color(0x550000FF),
              ),
            ),
          },
          outerSelector: _selectorController.stream,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            final random = new Random();
            _selectorController.sink.add(_types[random.nextInt(_types.length)]);
          });
        },
      ),
    );
  }

  Widget _buildPage(Color color) {
    return Container(
      color: color,
    );
  }

  Widget _buildElement(bool isSelected, Color color) {
    return Container(
      height: 100,
      color: color,
      child: isSelected
          ? Center(
              child: Icon(Icons.check),
            )
          : Container(),
    );
  }

  @override
  void dispose() {
    super.dispose();

    _selectorController.close();
  }
}
