import 'dart:async';

import 'package:flutter/material.dart';
import 'package:swipe_refresh/swipe_refresh.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Refresher Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _controller = StreamController<SwipeRefreshState>.broadcast();

  get _stream => _controller.stream;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 25),
          child: Column(
            children: <Widget>[
              TabBar(
                tabs: <Widget>[
                  _buildTab(SwipeRefreshStyle.material),
                  _buildTab(SwipeRefreshStyle.cupertino)
                ],
              ),
              Expanded(
                child: TabBarView(children: <Widget>[
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
                ]),
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
    var isMaterial = style == SwipeRefreshStyle.material;
    var color = isMaterial ? red : blue;
    color = color.withOpacity(.5);
    return InkWell(
      child: Container(
        height: 100,
        child: Center(
          child: Text(
            isMaterial ? "Material" : "Cupertino",
            style: TextStyle(color: color),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildExampleBody(SwipeRefreshStyle style) {
    var isMaterial = style == SwipeRefreshStyle.material;
    var color = isMaterial ? red : blue;
    return <Widget>[
      Container(
        color: color,
        height: 100,
        child: Center(
          child: Text(
            isMaterial ? "Material example" : "Coupertino example",
            style: TextStyle(color: white),
          ),
        ),
      ),
    ];
  }

  void _refresh() async {
    await Future.delayed(Duration(seconds: 3));
    // when all needed is done change state
    _controller.sink.add(SwipeRefreshState.hidden);
  }
}

const white = const Color(0xFFFFFFFF);
const red = const Color(0xFFFF0000);
const blue = const Color(0xFF0000FF);
