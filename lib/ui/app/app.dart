import 'package:flutter/material.dart';
import 'package:flutter_template/di/injector.dart';
import 'package:flutter_template/di/modules.dart';
import 'package:flutter_template/ui/screen/homepage/homepage.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Injector(
      component: AppComponent(),
      builder: (context) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: MyHomePage(
            title: "Template",
          )),
    );
  }
}
