// Copyright (c) 2019-present,  SurfStudio LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';
import 'package:surf_logger/surf_logger.dart';

void main() {
  _initLogger();
  runApp(MyApp());
}

void _initLogger() {
  Logger.addStrategy(DebugLogStrategy());
}

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key) {
    Logger.d('MyApp constructor');
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Logger.d('MyApp build');
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
  MyHomePage({Key key, this.title}) : super(key: key) {
    Logger.d('MyHomePage constructor');
  }

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState() {
    Logger.d('MyHomePageState constructor');
  }

  int _counter = 0;

  void _incrementCounter() {
    Logger.d('counter value = $_counter before setState');
    setState(() {
      _counter++;
    });
    Logger.d('counter value = $_counter after setState');
  }

  @override
  void initState() {
    Logger.d('MyHomePageState initState');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Logger.d('MyHomePageState build');
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
