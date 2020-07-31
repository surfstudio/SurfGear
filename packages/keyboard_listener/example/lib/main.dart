import 'package:flutter/material.dart';
import 'package:keyboard_listener/keyboard_listener.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InkWidget example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'InkWidget example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isVisible = false;

  KeyboardListener _keyboardListener;

  @override
  void initState() {
    super.initState();
    _keyboardListener = KeyboardListener()
      ..addListener(onChange: _keyboardHandle);
  }

  @override
  void dispose() {
    _keyboardListener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(_isVisible ? 'Visible' : 'hidden'),
          const SizedBox(height: 50),
          const TextField(),
          const SizedBox(height: 50),
          RaisedButton(
            onPressed: () {
              if (FocusManager.instance.primaryFocus != null) {
                FocusManager.instance.primaryFocus.unfocus();
              } else {
                FocusScope.of(context).requestFocus(FocusNode());
              }
            },
            child: const Text('Reset focus'),
          ),
        ],
      ),
    );
  }

  void _keyboardHandle(bool isVisible) {
    setState(() {
      _isVisible = isVisible;
    });
  }
}
