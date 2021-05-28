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
  test('EntityStreamedState content test', () async {
    final entityStreamedState = EntityStreamedState<String>();
    final result = <EntityState<String?>>[];
    entityStreamedState.stream.listen(result.add);
    await entityStreamedState.content('test');
    expect(result.map((state) => state.data).toList(), equals([null, 'test']));
  });

  test('EntityStreamedState error test', () async {
    final entityStreamedState = EntityStreamedState<String>();
    final result = <EntityState<String?>>[];
    entityStreamedState.stream.listen(result.add);
    await entityStreamedState.error(Exception());
    expect(
      result.map((state) => state.error).toList(),
      equals([null, isException]),
    );
  });

  test('EntityStreamedState loading test', () async {
    final entityStreamedState = EntityStreamedState<String>();
    final result = <EntityState<String?>>[];
    entityStreamedState.stream.listen(result.add);
    await entityStreamedState.loading();
    expect(
      result.map((state) => state.isLoading).toList(),
      equals([false, true]),
    );
  });
}
