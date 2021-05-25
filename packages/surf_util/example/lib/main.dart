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

import 'package:flutter/material.dart';
import 'package:surf_util/surf_util.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DisableOverscroll Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RefresherPage(),
    );
  }
}

class RefresherPage extends StatefulWidget {
  const RefresherPage({Key? key}) : super(key: key);

  @override
  _RefresherPageState createState() => _RefresherPageState();
}

class _RefresherPageState extends State<RefresherPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('DisableOverscroll'),
        ),
        body: DisableOverscroll(
          child: SingleChildScrollView(
            child: Column(
              children: Colors.primaries
                  .map(
                    (color) => Container(
                      height: 200,
                      color: color,
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}

const white = Color(0xFFFFFFFF);
const red = Color(0xFFFF0000);
const blue = Color(0xFF0000FF);
