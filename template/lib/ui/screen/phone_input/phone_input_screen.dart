/// Copyright (c) 2019-present,  SurfStudio LLC
/// 
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
/// 
///     http://www.apache.org/licenses/LICENSE-2.0
/// 
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_template/ui/app/di/app.dart';
import 'package:flutter_template/ui/common/formatters/phone_formatter.dart';
import 'package:flutter_template/ui/common/widgets/buttons.dart';
import 'package:flutter_template/ui/common/widgets/progress_bar.dart';
import 'package:flutter_template/ui/res/strings/strings.dart';
import 'package:flutter_template/ui/res/text_styles.dart';
import 'package:flutter_template/ui/screen/phone_input/di/phone_input_widget_module.dart';
import 'package:flutter_template/ui/screen/phone_input/phone_input_wm.dart';
import 'package:injector/injector.dart';
import 'package:mwwm/mwwm.dart';

/// Экран ввода телефона
class PhoneInputScreen extends StatefulWidget {
  @override
  _PhoneInputScreenState createState() => _PhoneInputScreenState();
}

class _PhoneInputScreenState extends WidgetState<PhoneInputScreen,
    PhoneInputWidgetModel, PhoneInputScreenComponent> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget buildState(BuildContext context) {
    return _buildScreen(context);
  }

  Widget _buildScreen(BuildContext context) {
    _textEditingController.addListener(() {
      wm.textChanges(_textEditingController.value.text);
    });

    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: StreamBuilder<bool>(
          stream: wm.buttonEnabledState.stream,
          initialData: false,
          builder: (context, snapshot) {
            return OpacityFab(
              onPressed: wm.nextAction.accept,
              enabled: snapshot.data,
            );
          }),
      body: SafeArea(
        top: true,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: ConstrainedBox(
            constraints: BoxConstraints.expand(height: 237.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(top: 36.0),
                    child: FlutterLogo()),
                Container(
                  width: 304,
                  height: 45,
                  child: Text(
                    phoneInputScreenText,
                    style: textRegular16,
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StreamBuilder<EntityState<String>>(
                    stream: wm.phoneInputState.stream,
                    initialData: wm.phoneInputState.value,
                    builder: _buildTextField,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(context, snapshot) {
    if (snapshot.data.isLoading) {
      return ProgressBar();
    } else {
      return TextFormField(
        autofocus: false,
        onFieldSubmitted: wm.nextAction,
        controller: _textEditingController,
        inputFormatters: [
          WhitelistingTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(10),
          RuNumberTextInputFormatter()
        ],
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          labelText: phoneInputHintText,
          prefixText: phonePrefix,
        ),
      );
    }
  }

  @override
  PhoneInputScreenComponent getComponent(BuildContext context) {
    return PhoneInputScreenComponent(
      Injector.of<AppComponent>(context).component,
      _scaffoldKey,
      Navigator.of(context),
    );
  }
}
