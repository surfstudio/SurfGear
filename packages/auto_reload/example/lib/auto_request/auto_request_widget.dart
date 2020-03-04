import 'package:auto_reload/auto_reload.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'domain/post.dart';

class DemoAutoRequestManager extends StatefulWidget {
  @override
  _DemoAutoRequestManagerState createState() => _DemoAutoRequestManagerState();
}

class _DemoAutoRequestManagerState extends State<DemoAutoRequestManager> {
  final _autoRequestManager = AutoRequestManager(minReloadDurationSeconds: 3);

  List<RequestStatus> _requestStatuses;

  @override
  void initState() {
    super.initState();
    _requestStatuses = List.generate(5, (idx) {
      _autoRequestManager.autoReload(
        id: idx.toString(),
        toReload: () => fetchPost(),
        onComplete: (id) => _complete(int.parse(id)),
      );
      return RequestStatus.error;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Spacer(),
        Text(
          'auto request example:',
          style: TextStyle(
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
          ),
        ),
        Column(
          children: _requestStatuses
              .asMap()
              .map((idx, status) {
                return MapEntry(idx, Text('request number $idx - $status'));
              })
              .values
              .toList(),
        ),
        const Spacer(),
      ],
    );
  }

  Future<Post> fetchPost() async {
    final response =
        await http.get('https://jsonplaceholder.typicode.com/posts/1');

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      return Post.fromJson(json.decode(response.body));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

  void _complete(int idx) {
    setState(() {
      _requestStatuses[idx] = RequestStatus.success;
    });
  }
}

enum RequestStatus {
  success,
  error,
}
