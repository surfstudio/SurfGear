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

import 'package:push_notification/push_notification.dart';

class Message extends NotificationPayload {
  const Message(
    Map<String, dynamic> messageData,
    String title,
    String body,
    this.extraInt,
    this.extraDouble,
  ) : super(messageData, title, body);

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      map,
      (map['notification'] as Map<String, dynamic>)['title'] as String,
      (map['notification'] as Map<String, dynamic>)['body'] as String,
      map['extraInt'] as int,
      map['extraDouble'] as double,
    );
  }

  final int extraInt;
  final double extraDouble;
}
