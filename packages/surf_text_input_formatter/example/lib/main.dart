import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:surf_text_input_formatter/surf_text_input_formatter.dart';

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
  final _paymentCardFormatter = PaymentCardTextInputFormatter();

  final _formatter0 = SeparateTextInputFormatter(
    separatorPositions: [7, 3, 5],
    separateSymbols: ['-', ' '],
    maxLength: 10,
    type: SeparateTextInputFormatterType.number,
  );
  final _formatter1 = SeparateTextInputFormatter(
    step: 5,
    stepSymbol: '//',
    separatorPositions: [1, 3, 5],
    separateSymbols: ['-', '.', ','],
    excludeRegExp: RegExp(r"\D"),
  );

  final _dateFormatter = DdMmYyyyTextInputFormatter();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildItem(
              text: 'xxxx xxxx xxxx xxxx (Платежная карта)',
              formatter: _paymentCardFormatter,
            ),
            _buildItem(text: 'xxx-x x xx', formatter: _formatter0),
            _buildItem(
              text: 'x-x.x,xx//xxxxx//xxxxx//xxxxx (без ограничений на длину)',
              formatter: _formatter1,
            ),
            _buildItem(text: 'xx.xx.xxxx (Дата)', formatter: _dateFormatter),
            _buildItem(
              text: 'ИНН физлица',
              formatter: InnTextInputFormatter.individual(),
            ),
            _buildItem(
              text: 'ИНН юрлица',
              formatter: InnTextInputFormatter.entity(),
            ),
            _buildItem(text: 'КПП', formatter: KppTextInputFormatter()),
            _buildItem(text: 'Бик', formatter: BicTextInputFormatter()),
            _buildItem(
              text: 'Номер счета',
              formatter: AccountNumberTextInputFormatter(),
            ),
            _buildItem(
              text: 'УИН/УИП',
              formatter: UinUipTextInputFormatter(),
            ),
            AnimatedPadding(
              duration: const Duration(microseconds: 200),
              padding: MediaQuery.of(context).viewInsets,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem({
    @required String text,
    @required TextInputFormatter formatter,
    TextInputType keyboardType = TextInputType.number,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(text),
        TextField(
          inputFormatters: [formatter],
          keyboardType: keyboardType,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
