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

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';

import 'login_wm.dart';

/// Login screen
class LoginScreen extends CoreMwwmWidget {
  LoginScreen({
    @required WidgetModelBuilder widgetModelBuilder,
    this.argument1,
    this.argument2,
  })  : assert(widgetModelBuilder != null),
        super(widgetModelBuilder: widgetModelBuilder);

  final String argument1;
  final int argument2;

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends WidgetState<LoginWm> {
  final logoText = 'sign in with github';
  final buttonText = 'sign in';

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    logoText,
                    style: const TextStyle(
                      fontFamily: 'Helvetica',
                      fontSize: 32,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  if (Platform.isAndroid)
                    MaterialButton(
                      onPressed: wm.loginAction,
                      color: Colors.blue,
                      child: Text(
                        buttonText,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  if (Platform.isIOS)
                    CupertinoButton(
                      child: Text(buttonText),
                      onPressed: wm.loginAction,
                      color: Colors.indigo,
                    ),
                ],
              ),
            ),
          ),
        ),
      );
}
