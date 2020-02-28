import 'package:flutter/material.dart';
import 'package:render_metrics/render_metrics.dart';
import 'package:render_metrics/src/manager/render_parameters_manager.dart';
import 'package:render_metrics/src/render/render_metrics.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Render Metrics Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Auto reload Home Page'),
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
  GlobalKey scaffoldKey = GlobalKey();

  RenderParametersManager renderManager;

  String _text0Id = 'text0Id';
  int _paddingId = 1;
  String _containerId = 'containerId';
  String _containerPositionedId = 'containerPositionedId';

  @override
  void initState() {
    super.initState();
    renderManager = RenderParametersManager();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            ListView(
              children: <Widget>[
                const SizedBox(height: 500),
                RenderMetricsObject(
                  id: _text0Id,
                  manager: renderManager,
                  child: Container(
                    color: Colors.black.withOpacity(.2),
                    child: Text('Текст0'),
                  ),
                ),
                RenderMetricsObject(
                  id: _paddingId,
                  onMount: (_, RenderMetricsBox box) {
                    print('mount');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text('Текст1'),
                  ),
                ),
                RenderMetricsObject(
                  id: _containerId,
                  manager: renderManager,
                  child: Container(
                    width: double.infinity,
                    height: 100,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 500),
              ],
            ),
            Positioned(
              top: 50,
              left: 10,
              child: RenderMetricsObject(
                id: _containerPositionedId,
                manager: renderManager,
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: RaisedButton(
        child: Text('Get the difference between\nText0 and the blue square'),
        onPressed: () {
          showDialog(
            context: scaffoldKey.currentContext,
            builder: _buildBottomSheet,
          );
        },
      ),
    );
  }

  Widget _buildBottomSheet(_) {
    return Material(
      child: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                RaisedButton(
                  child: Text('Back'),
                  onPressed: Navigator.of(context).pop,
                ),
                const SizedBox(height: 20),
                Text('Data text0: ${renderManager.getRenderData(
                  _text0Id,
                )}'),
                const SizedBox(
                  height: 10,
                ),
                _buildSeparator(),
                const SizedBox(
                  height: 10,
                ),
                Text('Data blue square: ${renderManager.getRenderData(
                  _containerPositionedId,
                )}'),
                const SizedBox(
                  height: 10,
                ),
                _buildSeparator(),
                const SizedBox(
                  height: 10,
                ),
                Text(
                    'The difference between text0 and the blue square: ${renderManager.getDiff(
                  _containerPositionedId,
                  _text0Id,
                )}'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSeparator() {
    return Container(
      width: double.infinity,
      height: 1,
      color: Colors.black,
    );
  }
}
