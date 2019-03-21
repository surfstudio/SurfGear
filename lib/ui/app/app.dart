import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/di/app.dart';
import 'package:flutter_template/di/base/injector.dart';
import 'package:flutter_template/ui/screen/homepage/homepage.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Injector(component: AppComponent(), builder: _buildApp);
  }

  Widget _buildApp(BuildContext context) {
    return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: _buildHome(),
          );
  }

  Widget _buildHome() {
    return MyHomePage(
      title: "Template",
    );
  }
}
