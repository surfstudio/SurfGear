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
import 'package:ink_widget/ink_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InkWidget example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'InkWidget example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key key,
    this.title,
  }) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWidget(
              onTap: () {},
              splashColor: Colors.green,
              child: const Text('default InkWidget'),
            ),
            const SizedBox(height: 20),
            InkWidget(
              disable: true,
              onTap: () {},
              child: const Text('disable InkWidget'),
            ),
            const SizedBox(height: 20),
            InkWidget(
              shapeBorder: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: const Text('Container with BoxDecoration'),
              ),
            ),
            const SizedBox(height: 20),
            InkWidget(
              onTap: () {},
              inkWellWidget: InkWell(onTap: () {}),
              child: const Text('Custom InkWell (see code)'),
            ),
            const SizedBox(height: 20),
            InkWidget(
              disable: true,
              onTap: () {},
              disableWidget: Container(
                height: 50,
                color: Colors.white.withOpacity(.2),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: const Text('text in disableWidget'),
                ),
              ),
              child: const Text('Custom disableWidget (see code)'),
            ),
          ],
        ),
      ),
    );
  }
}
