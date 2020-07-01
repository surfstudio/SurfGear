import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:surfpay/surfpay.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
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
          child: Surfpay(
            paymentCallback: (status) {
              print("оплачено со статусом $status");
            },
            customButton: (context, pay) {
              return OutlineButton(
                onPressed: pay,
                child: Text("Оплата"),
              );
            },
          ),
        ),
      ),
    );
  }
}
