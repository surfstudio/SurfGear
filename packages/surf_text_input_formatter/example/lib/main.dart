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
    //isFormatBeforeEnterNextSymbol: true,
  );

  final _dateFormatter = DdMmYyyyTextInputFormatter();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              _buildItem(
                text: 'xxxx xxxx xxxx xxxx (Payment card)',
                formatter: _paymentCardFormatter,
              ),
              _buildItem(text: 'xxx-x x xx', formatter: _formatter0),
              _buildItem(
                text: 'x-x.x,xx//xxxxx//xxxxx//xxxxx (no length limit)',
                formatter: _formatter1,
              ),
              _buildItem(
                text: 'xx.xx.xxxx (Date)',
                formatter: _dateFormatter,
              ),
              _buildItem(
                text: '#-# #.#//# (from schema)',

                /// formatter: SeparateTextInputFormatter(
                ///   separateSymbols: ['-', ' ', '.', '/', '/'],
                ///   separatorPositions: [1, 3, 5, 7, 8],
                ///   excludeRegExp: RegExp(r"\D"),
                /// ),
                formatter: SeparateTextInputFormatter.fromSchema(
                  '#-# #.#//#',
                  excludeRegExp: RegExp(r"\D"),
                ),
              ),
              _buildItem(
                text: '+7 (000) 000 00 00 (before)',
                formatter: PhoneTextInputFormatter(
                  '+7',
                  isFormatBeforeEnterNextSymbol: true,
                ),
              ),
              _buildItem(
                text: '8 (000) 000 00 00 (after)',
                formatter: PhoneTextInputFormatter('8'),
              ),
              _buildItem(
                text: 'ИНН individual',
                formatter: InnTextInputFormatter.individual(),
              ),
              _buildItem(
                text: 'ИНН entity',
                formatter: InnTextInputFormatter.entity(),
              ),
              _buildItem(text: 'KPP', formatter: KppTextInputFormatter()),
              _buildItem(text: 'Bic', formatter: BicTextInputFormatter()),
              _buildItem(
                text: 'Account number',
                formatter: AccountNumberTextInputFormatter(),
              ),
              _buildItem(
                text: 'UIN/UIP',
                formatter: UinUipTextInputFormatter(),
              ),
              const SizedBox(height: 100),
              AnimatedPadding(
                duration: const Duration(microseconds: 200),
                padding: MediaQuery.of(context).viewInsets,
              ),
            ],
          ),
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
