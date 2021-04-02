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

import 'package:auto_reload/auto_reload.dart';
import 'package:counter/auto_request/domain/post.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class DemoAutoRequestManager extends StatefulWidget {
  const DemoAutoRequestManager({Key? key}) : super(key: key);

  @override
  _DemoAutoRequestManagerState createState() => _DemoAutoRequestManagerState();
}

class _DemoAutoRequestManagerState extends State<DemoAutoRequestManager> {
  final _autoRequestManager = AutoRequestManager(minReloadDurationSeconds: 3);

  late List<RequestStatus> _requestStatuses;

  @override
  void initState() {
    super.initState();
    _requestStatuses = List.generate(5, (idx) {
      _autoRequestManager.autoReload(
        id: idx.toString(),
        toReload: fetchPost,
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
        const Text(
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
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      return Post.fromJson(jsonDecode(response.body) as Map<String, Object>);
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
