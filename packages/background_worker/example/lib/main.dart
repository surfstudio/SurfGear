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

import 'dart:convert';

import 'package:background_worker/background_worker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MaterialApp(home: MainScreen()));

class MainScreen extends StatefulWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _backgroundWorker = BackgroundWorker(capacity: 2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test App'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              _buildProgressIndicator(),
              _buildButton(),
            ],
          ),
          _buildControlButtons(),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return const Padding(
      padding: EdgeInsets.only(top: 16),
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          OutlineButton(
            onPressed: () async {
              await backgroundWork(null);
            },
            child: const Text('Do in Foreground'),
          ),
          OutlineButton(
            onPressed: () async {
              final workItem = WorkItem<List<Data>, dynamic>.calculate(
                backgroundWork,
              );
              await _backgroundWorker.send(workItem);
            },
            child: const Text('Do in Background'),
          ),
        ],
      ),
    );
  }

  Widget _buildControlButtons() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.play_arrow,
              size: 30,
            ),
            onPressed: _backgroundWorker.start,
          ),
          IconButton(
            icon: const Icon(
              Icons.stop,
              size: 30,
            ),
            onPressed: _backgroundWorker.stop,
          ),
        ],
      ),
    );
  }
}

// ignore: avoid_annotating_with_dynamic
Future<List<Data>> backgroundWork(dynamic _) async {
  final response = await http.get('http://jsonplaceholder.typicode.com/posts');
  final String json = response.body;
  // ignore: avoid_print
  print(json);
  return (jsonDecode(json) as List<dynamic>)
      .map<Data>((json) => Data.fromJson(json as Map<String, dynamic>))
      .toList();
}

class Data {
  Data({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      userId: json['userId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }

  final int userId;
  final int id;
  final String title;
  final String body;
}
