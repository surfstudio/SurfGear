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
import 'package:push_demo/ui/second_screen.dart';
import 'package:push_notification/push_notification.dart';

class SecondStrategy extends PushHandleStrategy<Message> {
  SecondStrategy(Message payload) : super(payload);

  @override
  void onTapNotification(NavigatorState? navigator) {
    debugPrint('on tap notification');

    navigator?.push<void>(
      MaterialPageRoute(
        builder: (context) => SecondScreen(payload),
      ),
    );
  }

  @override
  void onBackgroundProcess(Map<String, dynamic> message) {
    debugPrint('on process notification in background');
  }
}
