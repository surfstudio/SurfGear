import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

void main() {
  _initLogger();
  runApp(MyApp());
}

void _initLogger() {
  Logger.addStrategy(DebugLogStrategy());
}

class MyApp extends StatelessWidget {
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

  MyApp() {
    Logger.d('MyApp constructor');
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
  int _counter = 0;

  _MyHomePageState() {
    Logger.d('MyHomePageState constructor');
  }

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
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
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
