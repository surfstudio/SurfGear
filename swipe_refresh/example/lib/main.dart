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

  final _scrollColnfroller = ScrollController();
  final _scrollStreamController = StreamController<ScrollPosition>.broadcast();

  get _stream => _controller.stream;

  @override
  void initState() {
    super.initState();
    _scrollColnfroller.addListener(
      () {
        _scrollStreamController.add(_scrollColnfroller.position);
      },
    );
  }

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
              StreamBuilder<ScrollPosition>(
                stream: _scrollStreamController.stream,
                builder: (context, snapshot) {
                  return Row(
                    children: <Widget>[
                      Text(
                          'offset: ${snapshot.data != null ? snapshot.data.pixels.toStringAsFixed(2) : ''}'),
                      Spacer(),
                      Text(
                          'viewPort: ${snapshot.data != null ? snapshot.data.viewportDimension.toStringAsFixed(2) : ''}'),
                      Spacer(),
                      Text(
                          'after: ${snapshot.data != null ? snapshot.data.extentAfter.toStringAsFixed(2) : ''}'),
                    ],
                  );
                },
              ),
              Expanded(
                child: TabBarView(children: <Widget>[
                  SwipeRefresh.material(
                    stateStream: _stream,
                    onRefresh: _refresh,
                    scrollController: _scrollColnfroller,
                    children: _buildExampleBody(SwipeRefreshStyle.material),
                  ),
                  SwipeRefresh.cupertino(
                    stateStream: _stream,
                    onRefresh: _refresh,
                    scrollController: _scrollColnfroller,
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
    _scrollStreamController.close();

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
      Container(height: 200.0, color: Colors.grey[200]),
      Container(height: 200.0, color: Colors.grey[300]),
      Container(height: 200.0, color: Colors.grey[400]),
      Container(height: 200.0, color: Colors.grey[500]),
      Container(height: 200.0, color: Colors.grey[600]),
      Container(height: 200.0, color: Colors.grey[700]),
      Container(height: 200.0, color: Colors.grey[800]),
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
