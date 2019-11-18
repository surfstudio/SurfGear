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
              () => Container(
                color: Color(0xFFFF0000),
              ),
              (isSelected) => Container(
                height: 100,
                color: Color(0x55FF0000),
                child: isSelected ? Center(
                  child: Icon(Icons.check),
                ) : Container(),
              ),
            ),
            _types[1]: BottomNavigationRelationship(
              () => Container(
                color: Color(0xFF00FF00),
              ),
              (isSelected) => Container(
                height: 100,
                color: Color(0x5500FF00),
                child: isSelected ? Center(
                  child: Icon(Icons.check),
                ) : Container(),
              ),
            ),
          },
        ),
      ),
    );
  }
}
