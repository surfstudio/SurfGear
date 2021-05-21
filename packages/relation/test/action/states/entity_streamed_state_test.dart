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
import 'package:relation/relation.dart';

void main() {
  test('EntityStreamedState content test', () {
    final entityStreamedState = EntityStreamedState<String>();
    entityStreamedState.stream.listen((event) {
      expect(event?.data, 'test');
    });
    entityStreamedState.content('test');
  });

  test('EntityStreamedState error test', () {
    final entityStreamedState = EntityStreamedState<String>();
    entityStreamedState.stream.listen((event) {
      expect(event?.error, isException);
    });
    entityStreamedState.error(Exception());
  });

  test('EntityStreamedState loading test', () {
    final entityStreamedState = EntityStreamedState<String>();
    entityStreamedState.stream.listen((event) {
      expect(event?.isLoading, true);
    });
    entityStreamedState.loading();
  });
}
