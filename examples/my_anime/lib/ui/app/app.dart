import 'package:flutter/material.dart';
import 'package:my_anime/ui/screens/main_screen/main_screen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'My anime',
        theme: ThemeData.dark(),
        home: MainScreen(),
      );
}
