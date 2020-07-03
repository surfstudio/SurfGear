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
  StreamController<_DataState<String>> _streamController = StreamController();

  Stream<_DataState<String>> get _stream => _streamController.stream;

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
        child: StreamBuilder<_DataState<String>>(
          stream: _stream,
          builder: (_, AsyncSnapshot<_DataState<String>> snapshot) {
            if (snapshot?.data == null || snapshot.data.isLoad) {
              return CircularProgressIndicator();
            }
            return Text(snapshot.data.value);
          },
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _run() {
    LoadScenario<String>(
      make: _getData,
      onLoad: (_) {
        print('load');
        _streamController.add(_DataState.load());
      },
      onData: (String data) => print('onData'),
      ifHasData: (String data) {
        print('ifHasData = $data');
        _streamController.add(_DataState.fromData(data));
      },
      ifNoData: () {
        print('ifNoData');
        _streamController.add(_DataState.fromData('Empty Data'));
      },
      onError: (_) => _streamController.add(_DataState.fromData('Error')),
    ).run();
  }

  Future<String> _getData([String _]) async {
    await Future.delayed(const Duration(seconds: 2));
    return '1';
  }
}

class _DataState<T> {
  final bool isLoad;
  final T value;

  _DataState({this.isLoad, this.value});

  factory _DataState.fromData(T value) => _DataState(
        isLoad: false,
        value: value,
      );

  factory _DataState.load() => _DataState(
        isLoad: true,
        value: null,
      );
}
