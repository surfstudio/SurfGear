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
import 'package:flutter/widgets.dart';
import 'package:flutter_template/ui/common/widgets/buttons.dart';
import 'package:flutter_template/ui/res/strings/strings.dart';
import 'package:flutter_template/ui/res/text_styles.dart';
import 'package:flutter_template/ui/screen/welcome_screen/di/welcome_screen_component.dart';
import 'package:flutter_template/ui/screen/welcome_screen/welcome_screen_wm.dart';
import 'package:injector/injector.dart';
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
