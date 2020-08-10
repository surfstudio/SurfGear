import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:in_app_rate/in_app_rate.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: RaisedButton(
            onPressed: () async {
              final isSuccess = await InAppRate.openRatingDialog(
                isTest: false,
                onServiceError: () =>
                    print("Error: try open url to application store"),
              );
//              final isSuccess = await InAppRate.openRatingDialog(isTest: false)
//                  .catchError((error) {
//                return false;
//              });
              print('result is - $isSuccess');
            },
            child: Text('Open dialog'),
          ),
        ),
      ),
    );
  }
}
