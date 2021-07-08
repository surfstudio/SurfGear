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
import 'package:virtual_keyboard/virtual_keyboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
  const MyHomePage({
    required this.title,
    Key? key,
  }) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const _maxCount = 4;

  var _symbols = '';

  int get _symbolsCount => _symbols.length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_symbols),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(50),
              child: VirtualKeyboardWidget(
                virtualKeyboardEffect: VirtualKeyboardEffect.keyRipple,
                keyboardKeys: numericKeyboardKeys,
                onPressKey: _handleTapKey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  VirtualKeyboardKey _buildClear() {
    return VirtualKeyboardDeleteKey(
      useAsKey: true,
      widget: InkWell(
        splashColor: Colors.green,
        onTap: () {
          _symbols = '';
          numericKeyboardKeys[3][2] = buildDelete();
          setState(() {});
        },
        child: const SizedBox(
          height: 50,
          child: Center(child: Text('Clear')),
        ),
      ),
    );
  }

  void _handleTapKey(VirtualKeyboardKey key) {
    if (key is VirtualKeyboardDeleteKey) {
      if (_symbolsCount == 0) {
        return;
      }

      _symbols = _symbols.substring(0, _symbolsCount - 1);
    } else if (key is VirtualKeyboardNumberKey) {
      _symbols += key.value;
    }

    if (_symbolsCount >= _maxCount) {
      numericKeyboardKeys[3][2] = _buildClear();
    } else {
      numericKeyboardKeys[3][2] = buildDelete();
    }

    setState(() {});
  }
}

/// Клавиши для цифровой экранной клавиатуры
List<List<VirtualKeyboardKey>> numericKeyboardKeys = [
  for (var i = 1; i < 4; i++)
    [
      for (var j = 1; j < 4; j++) VirtualKeyboardNumberKey((i * j).toString()),
    ],
  [
    VirtualKeyboardEmptyStubKey(),
    VirtualKeyboardNumberKey(
      '0',
      widget: const Text('Zero'),
      keyDecoration: BoxDecoration(
        color: Colors.red.withOpacity(.1),
      ),
    ),
    buildDelete(),
  ],
];

VirtualKeyboardKey buildDelete() {
  return VirtualKeyboardDeleteKey(widget: const Text('delete'));
}
