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
import 'package:push_notification/push_notification.dart';

const String androidMipMapIcon = '@mipmap/ic_launcher';

class MessageScreen extends StatefulWidget {
  const MessageScreen(this.pushHandler, {Key? key}) : super(key: key);

  final PushHandler pushHandler;

  @override
  MessageScreenState createState() => MessageScreenState();
}

class MessageScreenState extends State<MessageScreen> {
  final List<Message> messageList = [];

  @override
  void initState() {
    super.initState();

    widget.pushHandler.messageSubject.listen((messageMap) {
      final message = Message.fromMap(messageMap);
      setState(() {
        messageList.add(message);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Push demo'),
      ),
      body: ListView.builder(
        itemCount: messageList.length,
        itemBuilder: (_, index) {
          final message = messageList[index];
          return ListTile(
            title: Text(message.title),
            subtitle: Text(message.body),
          );
        },
      ),
    );
  }
}
