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
import 'package:push_notification/push_notification.dart';

import 'notification/example_factory.dart';
import 'notification/messaging_service.dart';
import 'ui/app.dart';

///todo sample not working
///need to remove Logger inside native push module from android-standart
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final MessagingService messagingService = MessagingService();
  final PushHandler pushHandler = PushHandler(
    ExampleFactory(),
    NotificationController(() {
      // ignore: avoid_print
      print('permission denied');
    }),
    messagingService,
  );
  messagingService.requestNotificationPermissions();

  runApp(MyApp(
    pushHandler,
  ));
}
