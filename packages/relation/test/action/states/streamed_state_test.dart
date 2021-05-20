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
import 'package:relation/src/relation/state/streamed_state.dart';

void main() {
  test('StreamedState accept([T data]) test', () {
    final streamedState = StreamedState<String>();
    streamedState.stream.listen((event) {
      expect(event, equals('test'));
    });
    streamedState.accept('test');
  });

  test('StreamedState acceptUnique([T data]) test', () async {
    final result = <String>[];

    final streamedState = StreamedState<String>();
    streamedState.stream.listen((event) {
      result.add(event!);
    });

    await streamedState.acceptUnique('test');
    await streamedState.acceptUnique('test');

    expect(result, equals(['test']));
  });

  test('StreamedState dispose() test', () {
    final streamedState = StreamedState<String>()..dispose();
    expect(streamedState.stateSubject.isClosed, true);
  });
}
