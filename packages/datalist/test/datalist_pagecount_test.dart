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

import 'package:datalist/src/impl/datalist_page_count.dart';
import 'package:datalist/src/exceptions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  DataListPageCountTest.testNormalMerge();
  DataListPageCountTest.testMergePagesWithSpace();
  DataListPageCountTest.testMergeNotFromFirstPage();
  DataListPageCountTest.testMergeWithEmptyList();
  DataListPageCountTest.testMergeWithEmptyList2();
  DataListPageCountTest.testMergeEmptyListWithAnotherList();
  DataListPageCountTest.testMergeWithCollision1();
  DataListPageCountTest.testMergeWithCollision2();
  DataListPageCountTest.testMergeWithError();
}

class DataListPageCountTest {
  static void testNormalMerge() {
    test('testNormalMerge', () {
      final PageCountDataList<int> list1 = PageCountDataList<int>(
        data: [1, 2, 3, 4, 5],
        startPage: 0,
        pageSize: 5,
      );
      final PageCountDataList<int> list2 = PageCountDataList<int>(
        data: [6, 7, 8, 8, 10],
        startPage: 1,
        pageSize: 5,
      );
      final PageCountDataList<int> list3 = PageCountDataList<int>(
          data: [1, 2, 3, 4, 5, 6, 7, 8, 8, 10],
          startPage: 0,
          pageSize: 5,
          numPages: 2);

      list1.merge(list2);

      expect(list1, list3);
    });
  }

  static void testMergePagesWithSpace() {
    test('testMergePagesWithSpace', () {
      final PageCountDataList<int> list1 = PageCountDataList<int>(
        data: [1, 2, 3, 4, 5],
        startPage: 0,
        pageSize: 5,
      );
      final PageCountDataList<int> list2 = PageCountDataList<int>(
        data: [6, 7, 8, 8, 10],
        startPage: 2,
        pageSize: 5,
      );

      final PageCountDataList<int> list3 = PageCountDataList<int>(
          data: [1, 2, 3, 4, 5], startPage: 0, pageSize: 5, numPages: 1);

      try {
        list1.merge(list2);
      } on IncompatibleRangesException catch (e) {
        expect(e.runtimeType, IncompatibleRangesException);
        return;
      }

      expect(list1, list3);
    });
  }

  static void testMergeNotFromFirstPage() {
    test('testMergeNotFromFirstPage', () {
      final PageCountDataList<int> list1 = PageCountDataList<int>(
        data: [1, 2, 3, 4, 5],
        startPage: 4,
        pageSize: 5,
      );

      final PageCountDataList<int> list2 = PageCountDataList<int>(
        data: [6, 7, 8, 8, 10],
        startPage: 5,
        pageSize: 5,
      );

      final PageCountDataList<int> list3 = PageCountDataList<int>(
        data: [1, 2, 3, 4, 5, 6, 7, 8, 8, 10],
        startPage: 4,
        pageSize: 5,
        numPages: 2,
      );

      list1.merge(list2);

      expect(list1, list3);
    });
  }

  static void testMergeWithEmptyList() {
    test('testMergeWithEmptyList', () {
      final PageCountDataList<int> list1 = PageCountDataList(
        data: [1, 2, 3, 4, 5],
        startPage: 0,
        pageSize: 5,
      );
      final PageCountDataList<int> list2 = PageCountDataList(
        data: [],
        startPage: 2,
        pageSize: 5,
      );
      final PageCountDataList<int> list3 = PageCountDataList(
        data: [1, 2, 3, 4, 5],
        startPage: 0,
        pageSize: 5,
      );

      list1.merge(list2);

      expect(list1, list3);
    });
  }

  static void testMergeWithEmptyList2() {
    test('testMergeWithEmptyList2', () {
      final PageCountDataList<int> list1 = PageCountDataList(
        data: [],
        startPage: 0,
        pageSize: 5,
      );
      final PageCountDataList<int> list2 = PageCountDataList(
        data: [1, 2, 3, 4, 5],
        startPage: 2,
        pageSize: 5,
      );
      final PageCountDataList<int> list3 = PageCountDataList(
        data: [1, 2, 3, 4, 5],
        startPage: 0,
        pageSize: 5,
      );

      list1.merge(list2);

      expect(list1, list3);
    });
  }

  static void testMergeEmptyListWithAnotherList() {
    test('testMergeEmptyListWithAnotherList', () {
      final PageCountDataList<int> list1 = PageCountDataList(
        data: [1, 2, 3, 4, 5],
        startPage: 0,
        pageSize: 5,
      );
      final PageCountDataList<int> list2 = PageCountDataList.empty();

      final PageCountDataList<int> list3 = PageCountDataList(
        data: [1, 2, 3, 4, 5],
        startPage: 0,
        pageSize: 5,
      );

      list1.merge(list2);

      expect(list1, list3);
    });
  }

  static void testMergeWithCollision1() {
    test('testMergeWithCollision1', () {
      final PageCountDataList<int> list1 = PageCountDataList<int>(
        data: [1, 2, 3, 4, 5],
        startPage: 2,
        pageSize: 5,
      );
      final PageCountDataList<int> list2 = PageCountDataList<int>(
        data: [6, 7, 8, 8, 10],
        startPage: 1,
        pageSize: 5,
      );
      final PageCountDataList<int> list3 = PageCountDataList<int>(
          data: [6, 7, 8, 8, 10, 1, 2, 3, 4, 5],
          startPage: 1,
          pageSize: 5,
          numPages: 2);

      list1.merge(list2);

      expect(list1, list3);
    });
  }

  static void testMergeWithCollision2() {
    test('testMergeWithCollision2', () {
      final PageCountDataList<int> list1 = PageCountDataList<int>(
        data: [1, 2, 3, 4, 5],
        startPage: 0,
        numPages: 5,
        pageSize: 1,
      );
      final PageCountDataList<int> list2 = PageCountDataList<int>(
        data: [6, 7, 8, 9, 10],
        startPage: 1,
        numPages: 5,
        pageSize: 1,
      );
      final PageCountDataList<int> list3 = PageCountDataList<int>(
          data: [1, 6, 7, 8, 9, 10], startPage: 0, pageSize: 1, numPages: 6);

      list1.merge(list2);

      expect(list1, list3);
    });
  }

  static void testMergeWithError() {
    test('testMergeWithError', () {
      final PageCountDataList<int> list1 = PageCountDataList(
        data: [1, 2, 3, 4, 5],
        startPage: 2,
        pageSize: 5,
      );
      final PageCountDataList<int> list2 = PageCountDataList(
        data: [6, 7, 8, 8, 10],
        startPage: 1,
        pageSize: 1,
      );

      try {
        list1.merge(list2);
        // ignore: avoid_catching_errors
      } on ArgumentError catch (e) {
        expect(e.message, 'pageSize for merging DataList must be same');
        return;
      }
    });
  }
}
