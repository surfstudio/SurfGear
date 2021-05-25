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
import 'package:tabnavigator/tabnavigator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _tabController = StreamController<AppTab>.broadcast();
  final _initTab = AppTab.feed;

  Stream<AppTab> get tabStream => _tabController.stream;

  final _map = {
    AppTab.feed: () {
      return ListView.builder(
        itemCount: 100,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('item $index'),
            onTap: () {
              Navigator.of(context).push<void>(
                MaterialPageRoute(
                  builder: (context) => Scaffold(
                    appBar: AppBar(title: Text('item $index')),
                  ),
                ),
              );
            },
          );
        },
      );
    },
    AppTab.colors: () {
      return ListView(
        children: Colors.accents
            .map(
              (color) => Builder(builder: (context) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push<void>(
                      MaterialPageRoute(
                        builder: (context) => Scaffold(
                          appBar: AppBar(
                            backgroundColor: color,
                          ),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 100,
                    color: color,
                    child: const Center(
                      child: Text(
                        'tap me',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                );
              }),
            )
            .toList(),
      );
    },
    AppTab.info: () {
      return Builder(builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'TabNavigator',
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              'example',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            Text(
              'Powered by Surf',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        );
      });
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabNavigator(
        initialTab: _initTab,
        selectedTabStream: tabStream,
        mappedTabs: _map,
      ),
      bottomNavigationBar: StreamBuilder<AppTab>(
        stream: tabStream,
        initialData: _initTab,
        builder: (context, snapshot) {
          return BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.feedback),
                label: 'Feed',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.color_lens),
                label: 'Colors',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.info),
                label: 'Info',
              ),
            ],
            currentIndex: snapshot.hasData ? snapshot.data!.value : 0,
            onTap: (value) => _tabController.sink.add(AppTab.byValue(value)),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _tabController.close();
    super.dispose();
  }
}

class AppTab extends TabType {
  const AppTab._(int value) : super(value);

  static const feed = AppTab._(0);
  static const colors = AppTab._(1);
  static const info = AppTab._(2);

  static AppTab byValue(int value) {
    switch (value) {
      case 0:
        return feed;
      case 1:
        return colors;
      case 2:
        return info;
      default:
        throw Exception('no tab for such value');
    }
  }
}
