import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            Container(
              color: Color(0xFFFF0000),
            ),
            FlexibleBottomSheet(
              minPartHeight: 0.5,
              maxPartHeight: 1,
              children: <Widget>[
                _testContainer(Color(0xEEFFFF00)),
                _testContainer(Color(0xDD99FF00)),
                _testContainer(Color(0xCC00FFFF)),
                _testContainer(Color(0xBB555555)),
                _testContainer(Color(0xAAFF5555)),
                _testContainer(Color(0x9900FF00)),
                _testContainer(Color(0x8800FF00)),
                _testContainer(Color(0x7700FF00)),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showSheet,
      ),
    );
  }

  Widget _testContainer(Color color) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 100,
        color: color,
      ),
    );
  }

  void _showSheet() {
    showFlexibleBottomSheet(
      context: context,
      children: <Widget>[
        _testContainer(Color(0xEEFFFF00)),
        _testContainer(Color(0xDD99FF00)),
        _testContainer(Color(0xCC00FFFF)),
        _testContainer(Color(0xBB555555)),
        _testContainer(Color(0xAAFF5555)),
        _testContainer(Color(0x9900FF00)),
        _testContainer(Color(0x8800FF00)),
        _testContainer(Color(0x7700FF00)),
      ],
    );
  }
}
