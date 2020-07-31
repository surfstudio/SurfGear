import 'package:example/analytics_events.dart';
import 'package:example/firebase/firebase_analytic_event_sender.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:analytics/analytics.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AnalyticService _analyticsService;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    final analytics = FirebaseAnalytics();
    _analyticsService = DefaultAnalyticService()
      ..addActionPerformer(FirebaseAnalyticEventSender(analytics));
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
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            FlatButton(
              onPressed: () => _sendAnalyticAction(
                FantasticButtonTappedEvent(),
              ),
              child: const Text('Fantastic button'),
            ),
            FlatButton(
              onPressed: () => _sendAnalyticAction(
                SparklingButtonTappedEvent('some data'),
              ),
              child: const Text('Sparkling button'),
            ),
            FlatButton(
              onPressed: () => _sendAnalyticAction(DelightfulButtonTappedEvent(
                isDelightful: true,
              )),
              child: const Text('Delightful button'),
            ),
          ],
        ),
      ),
    );
  }
}
