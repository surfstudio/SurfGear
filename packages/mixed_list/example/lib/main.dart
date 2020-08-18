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

import 'package:example/pagination_mixed_list_demo.dart';
import 'package:flutter/material.dart';

import 'midex_list_demo.dart';

void main() => runApp(const MixedListDemoApp());

class MixedListDemoApp extends StatelessWidget {
  const MixedListDemoApp({Key key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MixedListDemoApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
              title: const Text('Mixed list demo app'),
              bottom: const TabBar(
                tabs: [
                  Tab(text: 'Mixed List Demo'),
                  Tab(text: 'Pagination Mixed List Demo'),
                ],
              )),
          body: TabBarView(children: [
            MixedListDemo(),
            const PaginationMixedListDemo(),
          ]),
        ));
  }
}
