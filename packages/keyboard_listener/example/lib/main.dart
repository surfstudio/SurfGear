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
import 'package:keyboard_listener/keyboard_listener.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Keyboard listener example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Keyboard listener example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    required this.title,
    Key? key,
  }) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isVisible = false;

  late KeyboardListener _keyboardListener;

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
        children: [
          Text(_isVisible ? 'Visible' : 'hidden'),
          const SizedBox(height: 50),
          const TextField(),
          const SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              if (FocusManager.instance.primaryFocus != null) {
                FocusManager.instance.primaryFocus!.unfocus();
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
