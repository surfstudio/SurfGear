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

import 'package:flutter_template/util/extensions.dart';
import 'package:push_notification/push_notification.dart';

class DebugPushMessage extends NotificationPayload {
  DebugPushMessage(
    Map<String, dynamic> messageData,
    String title,
    String body,
  ) : super(messageData, title, body);

  factory DebugPushMessage.fromMap(Map<String, dynamic> map) {
    final notificationJson = map.get<Map<String, dynamic>>('notification');
    return DebugPushMessage(
      map,
      notificationJson.get<String>('title'),
      notificationJson.get<String>('body'),
    );
  }
}
