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

import 'package:flutter_test/flutter_test.dart';
import 'package:push_notification/src/base/push_handle_strategy.dart';
import 'package:push_notification/src/base/push_handle_strategy_factory.dart';
import 'package:mocktail/mocktail.dart';

class PushHandleStrategyMock extends Mock implements PushHandleStrategy {}

class TestPushHandleStrategyFactory extends PushHandleStrategyFactory {
  @override
  StrategyBuilder get defaultStrategy => (_) => PushHandleStrategyMock();
}

void main() {
  test('test', () {
    expect(true, isTrue);
  });
}
