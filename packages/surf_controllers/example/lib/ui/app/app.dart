import 'package:example/ui/screen/home_screen/home_route.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (_) => HomeScreenRoute(),
    );
  }
}
