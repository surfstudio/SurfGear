import 'package:example/analytics_events.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:analytics/analytics.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AnalyticService _analyticsService;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  initState() {
    super.initState();

    final analytics = FirebaseAnalytics();
    _analyticsService = DefaultAnalyticService()
      ..addActionPerformer(FirebaseAnalyticEventSender(analytics))
      ..addActionPerformer(FirebaseUserPropertyUpdater(analytics));
  }

  void _sendAnalyticAction(AnalyticAction action) {
    _analyticsService.performAction(action);
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text('action send: $action')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            FlatButton(
              child: Text('Fantastic button'),
              onPressed: () =>
                  _sendAnalyticAction(FantasticButtonTappedEvent()),
            ),
            FlatButton(
              child: Text('Sparkling button'),
              onPressed: () =>
                  _sendAnalyticAction(SparklingButtonTappedEvent("some data")),
            ),
            FlatButton(
              child: Text('Delightful button'),
              onPressed: () =>
                  _sendAnalyticAction(DelightfulButtonTappedEvent(true)),
            ),
          ],
        ),
      ),
    );
  }
}
