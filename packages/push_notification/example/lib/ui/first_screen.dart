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

import '../domain/message.dart';

const String androidMipMapIcon = '@mipmap/ic_launcher';

class FirstScreen extends StatefulWidget {
  const FirstScreen(this.payload, {Key key}) : super(key: key);

  final Message payload;

  @override
  FirstScreenState createState() => FirstScreenState();
}

class FirstScreenState extends State<FirstScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First notification screen'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const Text('Incoming message'),
            Text('Title : ${widget.payload.title}'),
            Text('Body: ${widget.payload.body}'),
          ],
        ),
      ),
    );
  }
}
