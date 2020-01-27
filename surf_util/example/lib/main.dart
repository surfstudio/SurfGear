import 'dart:async';

import 'package:flutter/material.dart';
import 'package:relation/relation.dart';
import 'package:surf_util/surf_util.dart';
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
      home: RefresherPage(),
    );
  }
}

class RefresherPage extends StatefulWidget {
  @override
  _RefresherPageState createState() => _RefresherPageState();
}

class _RefresherPageState extends State<RefresherPage> {
  final _stream = StreamedState<SwipeRefreshState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("RefreshExample"),
        ),
        body: Column(
          children: <Widget>[
            TabBar(
              tabs: <Widget>[
                _buildTab(SwipeRefreshStyle.material),
                _buildTab(SwipeRefreshStyle.cupertino)
              ],
            ),
            Expanded(
              child: TabBarView(children: <Widget>[
                StreamedSwipeRefresh.material(
                  stateStream: _stream,
                  onRefresh: _refresh,
                  children: _buildExampleBody(SwipeRefreshStyle.material),
                ),
                StreamedSwipeRefresh.cupertino(
                  stateStream: _stream,
                  onRefresh: _refresh,
                  children: _buildExampleBody(SwipeRefreshStyle.cupertino),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
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
    _stream.accept(SwipeRefreshState.hidden);
  }
}

const white = const Color(0xFFFFFFFF);
const red = const Color(0xFFFF0000);
const blue = const Color(0xFF0000FF);
