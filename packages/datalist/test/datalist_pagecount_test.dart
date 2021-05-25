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

import 'package:datalist/src/exceptions.dart';
import 'package:datalist/src/impl/datalist_page_count.dart';
import 'package:test/test.dart';

void main() {
  test('testNormalMerge', () {
    final list1 = PageCountDataList<int>(
      data: [1, 2, 3, 4, 5],
      startPage: 0,
      pageSize: 5,
    );
    final list2 = PageCountDataList<int>(
      data: [6, 7, 8, 8, 10],
      startPage: 1,
      pageSize: 5,
    );
    final list3 = PageCountDataList<int>(
      data: [1, 2, 3, 4, 5, 6, 7, 8, 8, 10],
      startPage: 0,
      pageSize: 5,
      numPages: 2,
    );

    list1.merge(list2);

    expect(list1, equals(list3));
  });

  test('testMergePagesWithSpace', () {
    final list1 = PageCountDataList<int>(
      data: [1, 2, 3, 4, 5],
      startPage: 0,
      pageSize: 5,
    );
    final list2 = PageCountDataList<int>(
      data: [6, 7, 8, 8, 10],
      startPage: 2,
      pageSize: 5,
    );

    expect(
      () => list1.merge(list2),
      throwsA(isA<IncompatibleRangesException>()),
    );
  });

  test('testMergeNotFromFirstPage', () {
    final list1 = PageCountDataList<int>(
      data: [1, 2, 3, 4, 5],
      startPage: 4,
      pageSize: 5,
    );

    final list2 = PageCountDataList<int>(
      data: [6, 7, 8, 8, 10],
      startPage: 5,
      pageSize: 5,
    );

    final list3 = PageCountDataList<int>(
      data: [1, 2, 3, 4, 5, 6, 7, 8, 8, 10],
      startPage: 4,
      pageSize: 5,
      numPages: 2,
    );

    list1.merge(list2);

    expect(list1, equals(list3));
  });

  test('testMergeWithEmptyList', () {
    final list1 = PageCountDataList(
      data: [1, 2, 3, 4, 5],
      startPage: 0,
      pageSize: 5,
    );
    final list2 = PageCountDataList<int>(
      data: [],
      startPage: 2,
      pageSize: 5,
    );
    final list3 = PageCountDataList(
      data: [1, 2, 3, 4, 5],
      startPage: 0,
      pageSize: 5,
    );

    list1.merge(list2);

    expect(list1, equals(list3));
  });

  test('testMergeWithEmptyList2', () {
    final list1 = PageCountDataList<int>(
      data: [],
      startPage: 0,
      pageSize: 5,
    );
    final list2 = PageCountDataList(
      data: [1, 2, 3, 4, 5],
      startPage: 2,
      pageSize: 5,
    );
    final list3 = PageCountDataList(
      data: [1, 2, 3, 4, 5],
      startPage: 0,
      pageSize: 5,
    );

    list1.merge(list2);

    expect(list1, equals(list3));
  });

  test('testMergeEmptyListWithAnotherList', () {
    final list1 = PageCountDataList(
      data: [1, 2, 3, 4, 5],
      startPage: 0,
      pageSize: 5,
    );
    final list2 = PageCountDataList<int>.empty();
    final list3 = PageCountDataList(
      data: [1, 2, 3, 4, 5],
      startPage: 0,
      pageSize: 5,
    );

    list1.merge(list2);

    expect(list1, equals(list3));
  });

  test('testMergeWithCollision1', () {
    final list1 = PageCountDataList<int>(
      data: [1, 2, 3, 4, 5],
      startPage: 2,
      pageSize: 5,
    );
    final list2 = PageCountDataList<int>(
      data: [6, 7, 8, 8, 10],
      startPage: 1,
      pageSize: 5,
    );
    final list3 = PageCountDataList<int>(
      data: [6, 7, 8, 8, 10, 1, 2, 3, 4, 5],
      startPage: 1,
      pageSize: 5,
      numPages: 2,
    );

    list1.merge(list2);

    expect(list1, equals(list3));
  });

  test('testMergeWithCollision2', () {
    final list1 = PageCountDataList<int>(
      data: [1, 2, 3, 4, 5],
      startPage: 0,
      numPages: 5,
      pageSize: 1,
    );
    final list2 = PageCountDataList<int>(
      data: [6, 7, 8, 9, 10],
      startPage: 1,
      numPages: 5,
      pageSize: 1,
    );
    final list3 = PageCountDataList<int>(
      data: [1, 6, 7, 8, 9, 10],
      startPage: 0,
      pageSize: 1,
      numPages: 6,
    );

    list1.merge(list2);

    expect(list1, equals(list3));
  });

  test('testMergeWithError', () {
    final list1 = PageCountDataList(
      data: [1, 2, 3, 4, 5],
      startPage: 2,
      pageSize: 5,
    );
    final list2 = PageCountDataList(
      data: [6, 7, 8, 8, 10],
      startPage: 1,
      pageSize: 1,
    );

    try {
      list1.merge(list2);
      // ignore: avoid_catching_errors
    } on ArgumentError catch (e) {
      expect(e.message, equals('pageSize for merging DataList must be same'));
    }
  });
}
