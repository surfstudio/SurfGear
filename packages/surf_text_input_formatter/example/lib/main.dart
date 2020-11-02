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
      home: MyHomePage(),
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
  bool _isBefore = false;

  final _countryCode = '+7';

  TextEditingController _phoneController = TextEditingController();
  FocusNode _phoneFocusNode = FocusNode();

  String get _trimmedPhoneText => _phoneController.text.trim();

  bool get _isEmptyPhoneText => _trimmedPhoneText.isEmpty;

  @override
  void initState() {
    _phoneFocusNode.addListener(() {
      if (_phoneFocusNode.hasFocus && _isEmptyPhoneText) {
        _phoneController.text = _countryCode + ' ';
        return;
      } else if (!_phoneFocusNode.hasFocus &&
          _trimmedPhoneText == _countryCode) {
        _phoneController.clear();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              children: [
                Switch(
                  inactiveThumbColor: Colors.black,
                  inactiveTrackColor: Colors.white,
                  activeColor: Colors.white,
                  activeTrackColor: Colors.black,
                  value: _isBefore,
                  onChanged: (bool value) {
                    setState(() {
                      _isBefore = value;
                    });
                  },
                ),
                Text('formatting before')
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              _buildItem(
                text: 'xxxx xxxx xxxx xxxx (Payment card)',
                formatter: PaymentCardTextInputFormatter(
                  isFormatBeforeEnterNextSymbol: _isBefore,
                ),
              ),
              _buildItem(
                text: 'xxx-x x xx',
                formatter: SeparateTextInputFormatter(
                  separatorPositions: [7, 3, 5],
                  separateSymbols: ['-', ' '],
                  maxLength: 10,
                  type: SeparateTextInputFormatterType.number,
                  isFormatBeforeEnterNextSymbol: _isBefore,
                ),
              ),
              _buildItem(
                text: 'xxx-x x xx (from schema)',
                formatter: SeparateTextInputFormatter.fromSchema(
                  '###-# # ##',
                  maxLength: 10,
                  type: SeparateTextInputFormatterType.number,
                  isFormatBeforeEnterNextSymbol: _isBefore,
                ),
              ),
              _buildItem(
                text: 'x-x.x,xx//xxxxx//xxxxx//xxxxx (no length limit)',
                formatter: SeparateTextInputFormatter(
                  step: 5,
                  stepSymbol: '//',
                  separatorPositions: [1, 3, 5],
                  separateSymbols: ['-', '.', ','],
                  excludeRegExp: RegExp(r"\D"),
                  isFormatBeforeEnterNextSymbol: _isBefore,
                ),
              ),
              _buildItem(
                text:
                    'x-x.x,xx//xxxxx//xxxxx//xxxxx (no length limit, from schema)',
                formatter: SeparateTextInputFormatter.fromSchema(
                  '#-#.#,##//#####//#####//#####',
                  excludeRegExp: RegExp(r"\D"),
                  isFormatBeforeEnterNextSymbol: _isBefore,
                ),
              ),
              _buildItem(
                text: 'xx.xx.xxxx (Date)',
                formatter: DdMmYyyyTextInputFormatter(
                  isFormatBeforeEnterNextSymbol: _isBefore,
                ),
              ),
              _buildItem(
                text: '+7 (000) 000 00 00 - Insert country code by autofocus',
                formatter: PhoneTextInputFormatter(
                  _countryCode,
                  isFormatBeforeEnterNextSymbol: _isBefore,
                ),
                controller: _phoneController,
                focusNode: _phoneFocusNode,
              ),
              _buildItem(
                text: '8 (000) 000 00 00',
                formatter: PhoneTextInputFormatter(
                  '8',
                  isFormatBeforeEnterNextSymbol: _isBefore,
                ),
              ),
              _buildItem(
                text: 'ИНН individual',
                formatter: InnTextInputFormatter.individual(
                  isFormatBeforeEnterNextSymbol: _isBefore,
                ),
              ),
              _buildItem(
                text: 'ИНН entity',
                formatter: InnTextInputFormatter.entity(
                  isFormatBeforeEnterNextSymbol: _isBefore,
                ),
              ),
              _buildItem(
                text: 'KPP',
                formatter: KppTextInputFormatter(
                  isFormatBeforeEnterNextSymbol: _isBefore,
                ),
              ),
              _buildItem(
                text: 'Bic',
                formatter: BicTextInputFormatter(
                  isFormatBeforeEnterNextSymbol: _isBefore,
                ),
              ),
              _buildItem(
                text: 'Account number',
                formatter: AccountNumberTextInputFormatter(
                  isFormatBeforeEnterNextSymbol: _isBefore,
                ),
              ),
              _buildItem(
                text: 'UIN/UIP',
                formatter: UinUipTextInputFormatter(
                  isFormatBeforeEnterNextSymbol: _isBefore,
                ),
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
    TextEditingController controller,
    FocusNode focusNode,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(text),
        TextField(
          inputFormatters: [formatter],
          keyboardType: keyboardType,
          controller: controller,
          focusNode: focusNode,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
