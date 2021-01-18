import 'package:flutter/material.dart';
import 'package:in_app_rate/in_app_rate.dart';

// ignore_for_file: avoid_print

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              final isSuccess = await InAppRate.openRatingDialog(
                onError: () =>
                    print('Error: try open url to application store'),
              );
//              final isSuccess = await InAppRate.openRatingDialog(isTest: false)
//                  .catchError((error) {
//                return false;
//              });
              print('result is - $isSuccess');
            },
            child: const Text('Open dialog'),
          ),
        ),
      ),
    );
  }
}
