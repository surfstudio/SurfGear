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
import 'package:push_demo/ui/main_screen.dart';
import 'package:push_notification/push_notification.dart';

class MyApp extends StatelessWidget {
  const MyApp(this._pushHandler, {Key? key}) : super(key: key);

  final PushHandler _pushHandler;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [
        PushObserver(),
      ],
      title: 'Push demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: MessageScreen(_pushHandler),
    );
  }
}
