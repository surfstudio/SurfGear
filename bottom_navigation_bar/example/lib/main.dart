import 'dart:async';
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
      StreamController<BottomNavTabType>.broadcast();

  List<BottomNavTabType> _types;

  Map<BottomNavTabType, BottomNavigationRelationship> _map;

  bool _isCustom = true;

  @override
  void initState() {
    super.initState();

    _types = [
      BottomNavTabType(0),
      BottomNavTabType(1),
      BottomNavTabType(2),
    ];

    _map = {
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
    };

    _selectorController.stream.listen((type) => print(type.value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: _isCustom ? _buildWithCustom() : _buildWithCommon(),
      ),
    );
  }

  Widget _buildWithCommon() {
    return Container(
      child: _buildBottomNavigator(),
    );
  }

  Widget _buildWithCustom() {
    return Container(
      child: _buildCustomBottomNavigator(),
    );
  }

  BottomNavigator _buildBottomNavigator() {
    return BottomNavigator(
      key: UniqueKey(),
      initialTab: _types[0],
      tabsMap: _map,
      selectController: _selectorController,
    );
  }

  BottomNavigator _buildCustomBottomNavigator() {
    return BottomNavigator.custom(
      key: UniqueKey(),
      tabsMap: _map,
      initialTab: _types[0],
      bottomNavBar: _buildNavBar(),
      selectController: _selectorController,
    );
  }

  Widget _buildPage(Color color) {
    return Container(
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            child: Text("Change mode"),
            onPressed: () {
              setState(
                () {
                  _isCustom = !_isCustom;
                },
              );
            },
            color: Color(0xFFFFFFFF),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildChangeButton(0),
              _buildChangeButton(1),
              _buildChangeButton(2),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildChangeButton(int value) {
    return FlatButton(
      child: Text(value.toString()),
      onPressed: () {
        _selectorController.sink.add(_types[value]);
      },
      color: Color(0xFFFFFFFF),
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

  Widget _buildCustomElement(bool isSelected, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
      ),
      height: 100,
      child: isSelected
          ? Center(
              child: Icon(Icons.check),
            )
          : Container(),
    );
  }

  BottomNavBar _buildNavBar() {
    return BottomNavBar(
      elements: {
        _types[0]: (isSelected) => _buildCustomElement(
              isSelected,
              Color(0x55FF0000),
            ),
        _types[1]: (isSelected) => _buildCustomElement(
              isSelected,
              Color(0x5500FF00),
            ),
        _types[2]: (isSelected) => _buildCustomElement(
              isSelected,
              Color(0x550000FF),
            ),
      },
      initType: _types[0],
      selectedController:_selectorController,
    );
  }

  @override
  void dispose() {
    _selectorController.close();

    super.dispose();
  }
}
