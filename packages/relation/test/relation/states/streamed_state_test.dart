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
  test('not nullable StreamedState value getter test', () {
    final streamedState = StreamedState<String>('a');
    expect(streamedState.value, equals('a'));
    streamedState.accept('b');
    expect(streamedState.value, equals('b'));
  });
  test('nullable StreamedState value getter test', () {
    final streamedState = StreamedState<String?>(null);
    expect(streamedState.value, isNull);
    streamedState.accept('b');
    expect(streamedState.value, equals('b'));
  });
  test('StreamedState accept test', () async {
    final streamedState = StreamedState<String>('a');
    final result = <String?>[];

    streamedState.stream.listen(result.add);
    await streamedState.accept('a');
    await streamedState.accept('b');
    expect(result, equals(['a', 'a', 'b']));
  });

  test('StreamedState accept test with initial null', () async {
    final streamedState = StreamedState<String?>(null);
    final result = <String?>[];

    streamedState.stream.listen(result.add);
    await streamedState.accept('a');
    await streamedState.accept('b');
    expect(result, equals([null, 'a', 'b']));
  });

  test('StreamedState acceptUnique test', () async {
    final result = <String>[];

    final streamedState = StreamedState<String>('initial');
    streamedState.stream.listen(result.add);

    await streamedState.acceptUnique('a');
    await streamedState.acceptUnique('a');
    await streamedState.acceptUnique('b');
    await streamedState.acceptUnique('b');
    expect(result, equals(['initial', 'a', 'b']));
  });

  test('StreamedState dispose test', () {
    final streamedState = StreamedState<String>('initial')..dispose();
    expectLater(
      streamedState.stream,
      emitsInOrder(<dynamic>['initial', emitsDone]),
    );
  });
}
