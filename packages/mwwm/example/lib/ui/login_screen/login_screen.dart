import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';

import 'login_wm.dart';

/// Login screen
class LoginScreen extends CoreMwwmWidget {
  LoginScreen({
    @required WidgetModelBuilder widgetModelBuilder,
  })  : assert(widgetModelBuilder != null),
        super(widgetModelBuilder: widgetModelBuilder);

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
                    style: TextStyle(
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
                        style: TextStyle(
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
