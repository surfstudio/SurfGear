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

import 'package:flutter_template/domain/notification.dart';
import 'package:flutter_template/interactor/base/transformable.dart';
import 'package:flutter_template/util/extensions.dart';

/// Response модель пришедшего пуша
class FirebaseNotificationResponse extends Transformable<Notification> {
  FirebaseNotificationResponse({this.notification});

  FirebaseNotificationResponse.fromMessage(Map<String, dynamic> message) {
    notification = message['notification'] != null
        ? _FirebaseBodyNotificationObj.fromMessage(
            message.get<Map<String, dynamic>>('notification'),
          )
        : null;
  }

  _FirebaseBodyNotificationObj notification;

  @override
  Notification transform() => Notification(
        title: notification.title,
        text: notification.body,
        type: notification.data.get<String>('type'),
      );
}

class _FirebaseBodyNotificationObj {
  _FirebaseBodyNotificationObj({this.body, this.title});

  _FirebaseBodyNotificationObj.fromMessage(Map<String, dynamic> message) {
    body = message.get<String>('body');
    title = message.get<String>('title');
    data = message.get<Map<String, dynamic>>('data');
  }

  String body;
  String title;
  Map<String, dynamic> data;
}
