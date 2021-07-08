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
import 'package:relation/src/relation/action/streamed_action.dart';

void main() {
  test('accept test', () {
    final action = StreamedAction<String>();

    action.stream.listen((event) {
      expect(event, equals('test'));
    });

    action.accept('test');
  });

  test('acceptUnique test', () async {
    final action = StreamedAction<String>(acceptUnique: true);
    final result = <String?>[];

    action.stream.listen(result.add);

    await action.accept('test');
    await action.accept('test');

    expect(result, equals(['test']));
  });

  test('call test', () {
    final action = StreamedAction<String>();

    action.stream.listen((event) {
      expect(event, equals('test'));
    });

    action.call('test');
  });

  test('dispose test', () {
    final streamedState = StreamedAction<String>()..dispose();
    expectLater(streamedState.stream, emitsDone);
  });
}
