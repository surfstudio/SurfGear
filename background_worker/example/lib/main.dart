import 'package:background_worker/background_worker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MaterialApp(home: new MainScreen()));

class MainScreen extends StatefulWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _backgroudWorker = BackgroundWorker(capacity: 2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test App"),
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
          _buildControllButtons(),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
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
            child: Text("Do in Foreground"),
            onPressed: () async {
              await backgroundWork(null);
            },
          ),
          OutlineButton(
            child: Text("Do in Background"),
            onPressed: () async {
              var workItem = WorkItem<List<Data>, dynamic>.calculate(
                backgroundWork,
              );
              await _backgroudWorker.send(workItem);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildControllButtons() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.play_arrow,
              size: 30,
            ),
            onPressed: () => _backgroudWorker.start(),
          ),
          IconButton(
            icon: Icon(
              Icons.stop,
              size: 30,
            ),
            onPressed: () => _backgroudWorker.stop(),
          ),
        ],
      ),
    );
  }
}

Future<List<Data>> backgroundWork(dynamic) async {
  var response = await http.get('http://jsonplaceholder.typicode.com/posts');
  String json = response.body;
  print(json);
  return jsonDecode(json).map<Data>((json) => Data.fromJson(json)).toList();
}

class Data {
  final int userId;
  final int id;
  final String title;
  final String body;

  Data({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}
