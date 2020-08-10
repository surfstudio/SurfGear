// Copyright (c) 2019-present,  SurfStudio LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:relation/relation.dart';
import 'package:surf_util/surf_util.dart';
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
      home: const RefresherPage(),
    );
  }
}

class RefresherPage extends StatefulWidget {
  const RefresherPage({Key key}) : super(key: key);
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
          title: const Text('RefreshExample'),
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
    final isMaterial = style == SwipeRefreshStyle.material;
    var color = isMaterial ? red : blue;
    color = color.withOpacity(.5);
    return InkWell(
      child: Container(
        height: 100,
        child: Center(
          child: Text(
            isMaterial ? 'Material' : 'Cupertino',
            style: TextStyle(color: color),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildExampleBody(SwipeRefreshStyle style) {
    final isMaterial = style == SwipeRefreshStyle.material;
    final color = isMaterial ? red : blue;
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

  Future<void> _refresh() async {
    await Future<void>.delayed(const Duration(seconds: 3));
    // when all needed is done change state
    // ignore: unawaited_futures
    _stream.accept(SwipeRefreshState.hidden);
  }
}

const white = Color(0xFFFFFFFF);
const red = Color(0xFFFF0000);
const blue = Color(0xFF0000FF);
