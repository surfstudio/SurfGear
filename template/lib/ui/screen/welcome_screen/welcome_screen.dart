import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_template/ui/common/formatters/phone_formatter.dart';
import 'package:flutter_template/ui/common/widgets/buttons.dart';
import 'package:flutter_template/ui/common/widgets/progress_bar.dart';
import 'package:flutter_template/ui/res/strings/strings.dart';
import 'package:flutter_template/ui/res/text_styles.dart';
import 'package:flutter_template/ui/screen/welcome_screen/di/welcome_screen_component.dart';
import 'package:flutter_template/ui/screen/welcome_screen/welcome_screen_wm.dart';
import 'package:injector/injector.dart';
import 'package:mwwm/mwwm.dart';

/// Экран ввода телефона
class WelcomeScreen extends MwwmWidget<WelcomeScreenComponent> {
  WelcomeScreen([
    WidgetModelBuilder widgetModelBuilder = createWelcomeWidgetModel,
  ]) : super(
    dependenciesBuilder: (context) => WelcomeScreenComponent(context),
    widgetStateBuilder: () => _WelcomeScreenState(),
    widgetModelBuilder: widgetModelBuilder,
  );
}

class _WelcomeScreenState extends WidgetState<WelcomeScreenWidgetModel> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return _buildScreen(context);
  }

  Widget _buildScreen(BuildContext context) {
    _textEditingController.addListener(() {
      wm.textChanges(_textEditingController.value.text);
    });

    return Scaffold(
      key: Injector.of<WelcomeScreenComponent>(context).component.scaffoldKey,
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
}
