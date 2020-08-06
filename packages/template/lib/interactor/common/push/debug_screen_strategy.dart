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
import 'package:flutter_template/domain/debug_push_message.dart';
import 'package:flutter_template/ui/screen/debug/debug_route.dart';
import 'package:push_notification/push_notification.dart';

class DebugScreenStrategy extends PushHandleStrategy<DebugPushMessage> {
  DebugScreenStrategy(DebugPushMessage payload) : super(payload);

  @override
  // ignore: overridden_fields
  bool ongoing = true;

  @override
  // ignore: overridden_fields
  bool playSound = false;

  @override
  void onTapNotification(NavigatorState navigator) =>
      navigator.push(DebugScreenRoute());

  @override
  void onBackgroundProcess(Map<String, dynamic> message) {
    // ignore: avoid_print
    print('notification background process ${message.toString()}');
  }
}
