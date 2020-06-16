import 'package:flutter/material.dart';
import 'package:relation/relation.dart';
import 'package:scenario/result.dart';
import 'package:scenario/scenario.dart';
import 'package:scenario/scenarios/load_scenario.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scenario Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Scenario Example'),
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
  final _streamedState = EntityStreamedState<String>();

  @override
  void initState() {
    super.initState();
    _run();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: EntityStateBuilder<String>(
          streamedState: _streamedState,
          child: (_, String data) {
            return Text(data);
          },
          loadingChild: CircularProgressIndicator(),
          errorChild: Text('load'),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _run() {
    _MainScenario(streamedState: _streamedState).run();
  }
}

class _MainScenario extends BaseScenario {
  final EntityStreamedState streamedState;

  _MainScenario({
    this.streamedState,
  });

  void run() {
    LoadScenario(
      streamedState: streamedState,
      loadScenario: Scenario(
        steps: [
          StepScenario(
            loadMore: (_) async => 1,
            onResult: (r) => print('step 0 = $r'),
          ),
          StepScenario<int>(
            loadMore: (data) async {
              await Future.delayed(const Duration(seconds: 1));
              return 1 + data;
            },
            onResult: (r) => print('step 1 = $r'),
          ),
        ],
      ),
      dataScenario: Scenario(
        steps: [
          ConditionalStep(
            predicate: (data) async => false ? 'a' : 'b',
            steps: {
              'a': StepScenario(
                loadMore: (data) async => data,
                onResult: (Result r) => print('StepScenario a = ${r.data}'),
              ),
              'b': ConditionalStep(
                predicate: (data) async => data > 1 ? 'c' : 'd',
                onResult: (Result r) => print('ConditionalStep b = ${r.data}'),
                steps: {
                  'c': StepScenario(
                    loadMore: (data) async => data * 2,
                    onResult: (Result r) => print('StepScenario c = ${r.data}'),
                  ),
                  'd': StepScenario(
                    loadMore: (data) async => data * 10,
                    onResult: (Result r) => print('StepScenario d = ${r.data}'),
                  ),
                },
              ),
            },
          ),
        ],
      ),
    ).run();
  }
}
