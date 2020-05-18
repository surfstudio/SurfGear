import 'package:flutter/material.dart';
import 'package:mwwm_github_client/ui/repos/repository_search_screen.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RepositorySearchScreen(),
    );
  }
}
