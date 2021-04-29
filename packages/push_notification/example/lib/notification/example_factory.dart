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

import 'package:push_demo/domain/message.dart';
import 'package:push_demo/notification/first_strategy.dart';
import 'package:push_demo/notification/second_strategy.dart';
import 'package:push_notification/push_notification.dart';

class ExampleFactory extends PushHandleStrategyFactory {
  @override
  Map<String, StrategyBuilder> get map => {
        'type1': (payload) {
          final message = Message.fromMap(payload);
          return FirstStrategy(message);
        },
        'type2': (payload) {
          final message = Message.fromMap(payload);
          return SecondStrategy(message);
        },
      };

  @override
  StrategyBuilder get defaultStrategy {
    return (payload) => FirstStrategy(
          Message.fromMap(payload),
        );
  }
}
