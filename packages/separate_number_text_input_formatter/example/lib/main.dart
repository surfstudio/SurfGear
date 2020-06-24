import 'package:flutter/material.dart';
import 'package:separate_number_text_input_formatter/separate_number_text_input_formatter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Render Metrics Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Auto reload Home Page'),
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
  final _formatter0 = SpacesTextInputFormatter(
    step: 4,
    stepSymbol: ' ',
    maxLength: 20,
  );
  final _formatter1 = SpacesTextInputFormatter(
    separatorPositions: [7, 3, 5],
    separateSymbols: ['-', ' '],
    maxLength: 10,
  );
  final _formatter2 = SpacesTextInputFormatter(
    step: 5,
    stepSymbol: '/',
    separatorPositions: [1, 3, 5],
    separateSymbols: ['-', '.', ','],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Text('xxxx xxxx xxxx xxxx'),
          TextField(
            inputFormatters: [_formatter0],
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 20),
          Text('xxx-x x xx'),
          TextField(
            inputFormatters: [_formatter1],
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 20),
          Text('x-x.x,xx/xxxxx/xxxxx/xxxxx (без ограничений на длину)'),
          TextField(
            inputFormatters: [_formatter2],
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }
}
