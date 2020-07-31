import 'dart:async';

import 'package:flutter/material.dart';
import 'package:swipe_refresh/swipe_refresh.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Refresher Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _controller = StreamController<SwipeRefreshState>.broadcast();

  Stream<SwipeRefreshState> get _stream => _controller.stream;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 25),
          child: Column(
            children: <Widget>[
              TabBar(
                tabs: <Widget>[
                  _buildTab(SwipeRefreshStyle.material),
                  _buildTab(SwipeRefreshStyle.cupertino),
                  _buildTab(SwipeRefreshStyle.builder),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    SwipeRefresh.material(
                      stateStream: _stream,
                      onRefresh: _refresh,
                      children: _buildExampleBody(SwipeRefreshStyle.material),
                    ),
                    SwipeRefresh.cupertino(
                      stateStream: _stream,
                      onRefresh: _refresh,
                      children: _buildExampleBody(SwipeRefreshStyle.cupertino),
                    ),
                    SwipeRefresh.builder(
                      stateStream: _stream,
                      onRefresh: _refresh,
                      itemCount: Colors.primaries.length,
                      itemBuilder: (context, index) {
                        return Container(
                          color: Colors.primaries[index],
                          height: 100,
                          child: const Center(
                            child: Text(
                              'Builder example',
                              style: TextStyle(color: white),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.close();

    super.dispose();
  }

  Widget _buildTab(SwipeRefreshStyle style) {
    var color = _getColor(style);
    color = color.withOpacity(.5);
    return InkWell(
      child: Container(
        height: 100,
        child: Center(
          child: Text(
            _getText(style),
            style: TextStyle(color: color),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildExampleBody(SwipeRefreshStyle style) {
    final isMaterial = style == SwipeRefreshStyle.material;
    final color = _getColor(style);
    return <Widget>[
      Container(
        color: color,
        height: 100,
        child: Center(
          child: Text(
            isMaterial ? 'Material example' : 'Cupertino example',
            style: const TextStyle(color: white),
          ),
        ),
      ),
    ];
  }

  Color _getColor(SwipeRefreshStyle style) {
    switch (style) {
      case SwipeRefreshStyle.material:
        return red;
      case SwipeRefreshStyle.cupertino:
        return blue;
      case SwipeRefreshStyle.builder:
        return green;
      default:
        return black;
    }
  }

  String _getText(SwipeRefreshStyle style) {
    switch (style) {
      case SwipeRefreshStyle.material:
        return 'Material';
      case SwipeRefreshStyle.cupertino:
        return 'Cupertino';
      case SwipeRefreshStyle.builder:
        return 'Builder';
      default:
        return 'SipeRefresh';
    }
  }

  Future<void> _refresh() async {
    await Future<void>.delayed(const Duration(seconds: 3));
    // when all needed is done change state
    _controller.sink.add(SwipeRefreshState.hidden);
  }
}

const white = Color(0xFFFFFFFF);
const black = Color(0xFF000000);
const red = Color(0xFFFF0000);
const green = Color(0xFF00FF00);
const blue = Color(0xFF0000FF);
