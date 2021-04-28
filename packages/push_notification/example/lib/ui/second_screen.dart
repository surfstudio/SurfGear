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
import 'package:push_demo/domain/message.dart';

const String androidMipMapIcon = '@mipmap/ic_launcher';

class SecondScreen extends StatefulWidget {
  const SecondScreen(this.payload, {Key? key}) : super(key: key);

  final Message payload;

  @override
  SecondScreenState createState() => SecondScreenState();
}

class SecondScreenState extends State<SecondScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second notification screen'),
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
