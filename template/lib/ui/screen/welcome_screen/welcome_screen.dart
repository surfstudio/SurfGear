import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_template/ui/common/widgets/buttons.dart';
import 'package:flutter_template/ui/res/strings/strings.dart';
import 'package:flutter_template/ui/res/text_styles.dart';
import 'package:flutter_template/ui/screen/welcome_screen/di/welcome_screen_component.dart';
import 'package:flutter_template/ui/screen/welcome_screen/welcome_screen_wm.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

/// Экран ввода телефона
class WelcomeScreen extends MwwmWidget<WelcomeScreenComponent> {
  WelcomeScreen({
    Key key,
    WidgetModelBuilder widgetModelBuilder = createWelcomeWidgetModel,
  }) : super(
          key: key,
          dependenciesBuilder: (context) => WelcomeScreenComponent(context),
          widgetStateBuilder: () => _WelcomeScreenState(),
          widgetModelBuilder: widgetModelBuilder,
        );
}

class _WelcomeScreenState extends WidgetState<WelcomeScreenWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return _buildScreen(context);
  }

  Widget _buildScreen(BuildContext context) {
    return Scaffold(
      key: Injector.of<WelcomeScreenComponent>(context).component.scaffoldKey,
      floatingActionButton: OpacityFab(
        onPressed: wm.nextAction.accept,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ConstrainedBox(
            constraints: const BoxConstraints.expand(height: 237.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Padding(
                    padding: EdgeInsets.only(top: 36.0),
                    child: FlutterLogo(
                      size: 128,
                    )),
                SizedBox(
                  width: 304,
                  height: 45,
                  child: Text(
                    welcomeScreenText,
                    style: textRegular16,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
