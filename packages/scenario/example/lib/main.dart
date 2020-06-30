import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scenario/scenario.dart';
import 'package:scenario/scenarios/load_scenario.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scenario Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Scenario Example'),
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

  StreamController<String> _streamController = StreamController();

  Stream<String> get _stream => _streamController.stream;

  @override
  void initState() {
    super.initState();
    _run();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: StreamBuilder<String>(
          stream: _stream,
          builder: (_, AsyncSnapshot<String> snapshot) {
            if (snapshot.data == null) {
              return CircularProgressIndicator();
            }
            return Text(snapshot.data);
          },
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _run() {
    LoadScenario<String>(
      make: _getData,
      onLoad: (_) => print('load'),
      onData: (String data) => _streamController.add(data),
      ifHasData: (String data) => print('ifHasData = $data'),
      ifNoData: () => print('ifNoData'),
      onEmpty: () => _streamController.add('0'),
      onError: (_) => _streamController.add('-1'),
    ).run();
  }

//  void _runFromScenario() {
//    LoadScenario<String>.fromScenario(
//      scenario: Scenario(
//        steps: [
//          ScenarioStep<String>(
//              make: (_) async => '10',
//          ),
//        ]
//      ),
//      onLoad: () => print('load fromScenario'),
//      onData: (String data) => print('onData fromScenario = $data'),
//      ifHasData: (String data) => _streamController.add('fromScenario $data'),
//      ifNoData: () => _streamController.add('fromScenario 0'),
//      onError: (_) => _streamController.add('fromScenario -1'),
//    ).run();
//  }

  Future<String> _getData(_) async {
    await Future.delayed(const Duration(seconds: 2));
    return '1';
  }

}