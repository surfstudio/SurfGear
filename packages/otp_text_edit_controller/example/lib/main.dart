import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otp_text_edit_controller/otp_interactor.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  OTPInteractor otpInteractor;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    otpInteractor = OTPInteractor(myFunc)..startListen();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: TextField(
            controller: controller,
            onTap: () {
              OTPInteractor.hint.then((value) => controller.text = value);
            },
          ),
        ),
      ),
    );
  }

  void myFunc(String p1) {
    print(p1);
  }
}
