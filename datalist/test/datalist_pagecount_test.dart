import 'package:datalist/src/datalist_pagecount.dart';
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
    test("testNormalMerge", () {
      PageCountDataList<int> list1 = PageCountDataList<int>(
        data: [1, 2, 3, 4, 5],
        startPage: 0,
        pageSize: 5,
      );
      PageCountDataList<int> list2 = PageCountDataList<int>(
        data: [6, 7, 8, 8, 10],
        startPage: 1,
        pageSize: 5,
      );
      PageCountDataList<int> list3 = PageCountDataList<int>(
          data: [1, 2, 3, 4, 5, 6, 7, 8, 8, 10],
          startPage: 0,
          pageSize: 5,
          numPages: 2);

      list1.merge(list2);

      expect(list1, list3);
    });
  }

  static void testMergePagesWithSpace() {
    test("testMergePagesWithSpace", () {
      PageCountDataList<int> list1 = PageCountDataList<int>(
        data: [1, 2, 3, 4, 5],
        startPage: 0,
        pageSize: 5,
      );
      PageCountDataList<int> list2 = PageCountDataList<int>(
        data: [6, 7, 8, 8, 10],
        startPage: 2,
        pageSize: 5,
      );

      PageCountDataList<int> list3 = PageCountDataList<int>(
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
    test("testMergeNotFromFirstPage", () {
      PageCountDataList<int> list1 = PageCountDataList<int>(
        data: [1, 2, 3, 4, 5],
        startPage: 4,
        pageSize: 5,
      );

      PageCountDataList<int> list2 = PageCountDataList<int>(
        data: [6, 7, 8, 8, 10],
        startPage: 5,
        pageSize: 5,
      );

      PageCountDataList<int> list3 = PageCountDataList<int>(
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
    test("testMergeWithEmptyList", () {
      PageCountDataList<int> list1 = PageCountDataList(
        data: [1, 2, 3, 4, 5],
        startPage: 0,
        pageSize: 5,
      );
      PageCountDataList<int> list2 = PageCountDataList(
        data: [],
        startPage: 2,
        pageSize: 5,
      );
      PageCountDataList<int> list3 = PageCountDataList(
        data: [1, 2, 3, 4, 5],
        startPage: 0,
        pageSize: 5,
      );

      list1.merge(list2);

      expect(list1, list3);
    });
  }

  static void testMergeWithEmptyList2() {
    test("testMergeWithEmptyList2", () {
      PageCountDataList<int> list1 = PageCountDataList(
        data: [],
        startPage: 0,
        pageSize: 5,
      );
      PageCountDataList<int> list2 = PageCountDataList(
        data: [1, 2, 3, 4, 5],
        startPage: 2,
        pageSize: 5,
      );
      PageCountDataList<int> list3 = PageCountDataList(
        data: [1, 2, 3, 4, 5],
        startPage: 0,
        pageSize: 5,
      );

      list1.merge(list2);

      expect(list1, list3);
    });
  }

  static void testMergeEmptyListWithAnotherList() {
    test("testMergeEmptyListWithAnotherList", () {
      PageCountDataList<int> list1 = PageCountDataList(
        data: [1, 2, 3, 4, 5],
        startPage: 0,
        pageSize: 5,
      );
      PageCountDataList<int> list2 = PageCountDataList.empty();

      PageCountDataList<int> list3 = PageCountDataList(
        data: [1, 2, 3, 4, 5],
        startPage: 0,
        pageSize: 5,
      );

      list1.merge(list2);

      expect(list1, list3);
    });
  }

  static void testMergeWithCollision1() {
    test("testMergeWithCollision1", () {
      PageCountDataList<int> list1 = PageCountDataList<int>(
        data: [1, 2, 3, 4, 5],
        startPage: 2,
        pageSize: 5,
      );
      PageCountDataList<int> list2 = PageCountDataList<int>(
        data: [6, 7, 8, 8, 10],
        startPage: 1,
        pageSize: 5,
      );
      PageCountDataList<int> list3 = PageCountDataList<int>(
          data: [6, 7, 8, 8, 10, 1, 2, 3, 4, 5],
          startPage: 1,
          pageSize: 5,
          numPages: 2);

      list1.merge(list2);

      expect(list1, list3);
    });
  }

  static void testMergeWithCollision2() {
    test("testMergeWithCollision2", () {
      PageCountDataList<int> list1 = PageCountDataList<int>(
        data: [1, 2, 3, 4, 5],
        startPage: 0,
        numPages: 5,
        pageSize: 1,
      );
      PageCountDataList<int> list2 = PageCountDataList<int>(
        data: [6, 7, 8, 9, 10],
        startPage: 1,
        numPages: 5,
        pageSize: 1,
      );
      PageCountDataList<int> list3 = PageCountDataList<int>(
          data: [1, 6, 7, 8, 9, 10], startPage: 0, pageSize: 1, numPages: 6);

      list1.merge(list2);

      expect(list1, list3);
    });
  }

  static void testMergeWithError() {
    test("testMergeWithError", () {
      PageCountDataList<int> list1 = PageCountDataList(
        data: [1, 2, 3, 4, 5],
        startPage: 2,
        pageSize: 5,
      );
      PageCountDataList<int> list2 = PageCountDataList(
        data: [6, 7, 8, 8, 10],
        startPage: 1,
        pageSize: 1,
      );

      try {
        list1.merge(list2);
      } on ArgumentError catch (e) {
        expect(e.message, 'pageSize for merging DataList must be same');
        return;
      }
    });
  }
}
