import 'package:flutter/material.dart';
import 'package:virtual_keyboard/virtual_keyboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InkWidget example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'InkWidget example'),
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
  String _symbols = '';

  final int _maxCount = 4;

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
          children: <Widget>[
            Text(_symbols),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(50),
              child: VirtualKeyboardWidget(
                virtualKeyboardEffect: VirtualKeyboardEffect.keyRipple,
                keyboardKeys: _KeyboardUtils.numericKeyboardKeys,
                onPressKey: _handleTapKey,
              ),
            )
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
        child: SizedBox(
          height: 50,
          child: Center(child: Text('Clear')),
        ),
        onTap: () {
          _symbols = '';
          _KeyboardUtils.numericKeyboardKeys[3][2] =
              _KeyboardUtils.buildDelete();
          setState(() {});
        },
      ),
    );
  }

  void _handleTapKey(VirtualKeyboardKey key) {
    if (key is VirtualKeyboardDeleteKey) {
      if (_symbolsCount == 0) return;

      _symbols = _symbols.substring(0, _symbolsCount - 1);
    } else if (key is VirtualKeyboardNumberKey) {
      _symbols += key.value;
    }

    if (_symbolsCount >= _maxCount) {
      _KeyboardUtils.numericKeyboardKeys[3][2] = _buildClear();
    } else {
      _KeyboardUtils.numericKeyboardKeys[3][2] = _KeyboardUtils.buildDelete();
    }
    setState(() {});
  }
}

abstract class _KeyboardUtils {
  /// Клавиши для цифровой жкранной клавиатуры
  static List<List<VirtualKeyboardKey>> numericKeyboardKeys = [
    for (int i = 1; i < 4; i++)
      [
        for (int j = 1; j < 4; j++)
          VirtualKeyboardNumberKey((i * j).toString()),
      ],
    [
      VirtualKeyboardEmptyStubKey(),
      VirtualKeyboardNumberKey(
        '0',
        widget: Text('Zero'),
        keyDecoration: BoxDecoration(
          color: Colors.red.withOpacity(.1),
        ),
      ),
      buildDelete(),
    ],
  ];

  static VirtualKeyboardKey buildDelete() {
    return VirtualKeyboardDeleteKey(
      widget: Text('delete'),
    );
  }
}
