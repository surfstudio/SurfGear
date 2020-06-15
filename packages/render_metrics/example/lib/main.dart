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
  RenderParametersManager renderManager = RenderParametersManager();

  String _text0Id = 'text0Id';
  String _text1Id = 'text1Id';
  String _containerPositionedId = 'containerPositionedId';
  String _textBlockId = 'textBlockId';

  final _scrollController = ScrollController();

  bool _isOpacity = false;

  String _text0 = '';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    setState(() {});
  }

  void _scrollListener() {
    setState(() {
      _text0 = _getRenderDataText(_text0Id);
    });

    final ComparisonDiff diff =
        renderManager.getDiffById(_containerPositionedId, _textBlockId);

    _changeBlockUi(diff.diffBottomToTop > 0);
  }

  void _changeBlockUi(bool isChange) {
    if (_isOpacity == isChange) return;
    setState(() {
      _isOpacity = isChange;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            ListView(
              controller: _scrollController,
              children: <Widget>[
                const SizedBox(height: 500),
                RenderMetricsObject(
                  id: _textBlockId,
                  manager: renderManager,
                  onMount: (id, box) {
                    // Method called when creating a RenderObject
                    // id - passed id (In this case, the string from _textBlockId)
                    // box - renderMetricsBox instance from which data is taken
                  },
                  onUnMount: (box) {
                    // Method called when RenderObject is removed from the tree
                    // box - renderMetricsBox instance from which data is taken
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      RenderMetricsObject(
                        id: _text1Id,
                        manager: renderManager,
                        child: _buildTextContainer(
                          'Diff metrics between the current and the blue square:'
                          '\n\n'
                          '${renderManager.getDiffById(_text1Id, _containerPositionedId) ?? ''}',
                        ),
                      ),
                      const SizedBox(height: 20),
                      RenderMetricsObject(
                        id: _text0Id,
                        manager: renderManager,
                        child: _buildTextContainer(
                          'Metrics:\n\n$_text0',
                        ),
                      ),
                      const SizedBox(height: 1500),
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              top: 50,
              left: 10,
              child: _buildBox(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBox() {
    return RenderMetricsObject(
      id: _containerPositionedId,
      manager: renderManager,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 250),
        opacity: _isOpacity ? .5 : 1,
        child: Container(
          width: 300,
          height: 210,
          color: Colors.blue,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              'Blue Container() widget metrics:'
              '\n\n'
              '${_getRenderDataText(_containerPositionedId)}',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextContainer(String text) {
    return Container(
      color: Colors.black.withOpacity(.2),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          text,
        ),
      ),
    );
  }

  String _getRenderDataText<T>(T id) {
    final data = renderManager.getRenderData(id);
    if (data == null) return '';
    return data.toString();
  }
}
