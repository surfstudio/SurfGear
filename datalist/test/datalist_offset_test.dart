import 'package:datalist/src/impl/datalist_limit_offset.dart';
import 'package:datalist/src/exceptions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  DataListOffsetTest.testCheckNormalMerge();
  DataListOffsetTest.checkNormalMergeWithOffset();
  DataListOffsetTest.checkNormalMergeWithOffsetAndCollision();
  DataListOffsetTest.checkMergeWithCollision();
  DataListOffsetTest.checkMergeWithCollision2();
  DataListOffsetTest.checkMergeWithCollision3();
  DataListOffsetTest.checkMergeWithCollision4();
  DataListOffsetTest.checkMergeEmptyWithNormal();
  DataListOffsetTest.checkInvalidData();
  DataListOffsetTest.transformToStringDataList();
  DataListOffsetTest.checkDynamicDataInsertion();
  DataListOffsetTest.checkDynamicDataInsertion2();
  DataListOffsetTest.checkDynamicDataInsertion3();
}

class DataListOffsetTest {
  static void testCheckNormalMerge() {
    test(
      "testCheckNormalMerge",
      () {
        OffsetDataList<int> list1 = OffsetDataList<int>(
          data: [1, 2, 3, 4, 5],
          limit: 5,
          offset: 0,
          totalCount: 10,
        );
        OffsetDataList<int> list2 = OffsetDataList(
          data: [6, 7, 8, 9, 10],
          limit: 5,
          offset: 5,
          totalCount: 5,
        );
        OffsetDataList<int> list3 = OffsetDataList(
          data: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
          limit: 10,
          offset: 0,
          totalCount: 10,
        );
        list1.merge(list2);
        expect(list3, list1);
      },
    );
  }

  static void checkNormalMergeWithOffset() {
    test("checkNormalMergeWithOffset", () {
      OffsetDataList<int> list1 = OffsetDataList<int>(
        data: [1, 2, 3, 4, 5],
        limit: 5,
        offset: 7,
        totalCount: 10,
      );
      OffsetDataList<int> list2 = OffsetDataList(
        data: [6, 7, 8, 9, 10],
        limit: 5,
        offset: 12,
        totalCount: 10,
      );
      OffsetDataList<int> list3 = OffsetDataList(
        data: [6, 7, 8, 9, 10],
        limit: 5,
        offset: 17,
        totalCount: 10,
      );
      OffsetDataList<int> list4 = OffsetDataList(
          data: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 6, 7, 8, 9, 10],
          limit: 15,
          offset: 7,
          totalCount: 10);
      list3.merge(list2);
      list3.merge(list1);
      expect(list3, list4);
    });
  }

  static void checkNormalMergeWithOffsetAndCollision() {
    test('checkNormalMergeWithOffsetAndCollision', () {
      OffsetDataList<int> list1 = OffsetDataList<int>(
          data: [1, 2, 3, 4, 5], limit: 5, offset: 7, totalCount: 10);
      OffsetDataList<int> list2 = OffsetDataList(
          data: [6, 7, 8, 9, 10], limit: 5, offset: 12, totalCount: 10);
      OffsetDataList<int> list3 = OffsetDataList(
          data: [6, 7, 8, 9, 10], limit: 5, offset: 14, totalCount: 10);
      OffsetDataList<int> list4 = OffsetDataList(
          data: [1, 2, 3, 4, 5, 6, 7, 6, 7, 8, 9, 10],
          limit: 12,
          offset: 7,
          totalCount: 10);
      list3.merge(list2);
      list3.merge(list1);
      expect(list3, list4);
    });
  }

  static void checkMergeWithCollision() {
    test('checkMergeWithCollision', () {
      OffsetDataList<int> list1 =
          OffsetDataList(data: [1, 2, 3], limit: 3, offset: 0, totalCount: 10);
      OffsetDataList<int> list2 =
          OffsetDataList(data: [6, 7], limit: 3, offset: 0, totalCount: 10);
      OffsetDataList<int> list3 =
          OffsetDataList(data: [6, 7], limit: 3, offset: 0, totalCount: 10);
      list1.merge(list2);
      expect(list1, list3);
    });
  }

  static void checkMergeWithCollision2() {
    test('checkMergeWithCollision2', () {
      OffsetDataList<int> list1 =
          OffsetDataList(data: [1, 2, 3], limit: 3, offset: 2, totalCount: 10);
      OffsetDataList<int> list2 =
          OffsetDataList(data: [4, 5], limit: 3, offset: 4, totalCount: 10);
      OffsetDataList<int> list3 =
          OffsetDataList(data: [1, 2, 4, 5], limit: 5, offset: 2, totalCount: 10);
      list1.merge(list2);
      expect(list1, list3);
    });
  }

  static void checkMergeWithCollision3() {
    test('checkMergeWithCollision3', () {
      OffsetDataList<int> list1 =
          OffsetDataList(data: [1, 2, 3, 4, 5], limit: 5, offset: 0, totalCount: 10);
      OffsetDataList<int> list2 =
          OffsetDataList(data: [6, 7], limit: 3, offset: 0, totalCount: 10);
      OffsetDataList<int> list3 =
          OffsetDataList(data: [6, 7], limit: 3, offset: 0, totalCount: 10);
      list1.merge(list2);
      expect(list1, list3);
    });
  }

  static void checkMergeWithCollision4() {
    test('checkMergeWithCollision4', () {
      OffsetDataList<int> list1 =
          OffsetDataList(data: [6, 7], limit: 3, offset: 0, totalCount: 10);
      OffsetDataList<int> list2 =
          OffsetDataList(data: [1, 2, 3, 4, 5], limit: 5, offset: 0, totalCount: 10);
      OffsetDataList<int> list3 =
          OffsetDataList(data: [1, 2, 3, 4, 5], limit: 5, offset: 0, totalCount: 10);
      list1.merge(list2);
      expect(list1, list3);
    });
  }

  static void checkMergeEmptyWithNormal() {
    test('checkMergeEmptyWithNormal', () {
      OffsetDataList<int> list1 = OffsetDataList.empty();
      OffsetDataList<int> list2 =
          OffsetDataList(data: [1, 2, 3, 4, 5], limit: 5, offset: 0, totalCount: 10);
      OffsetDataList<int> list3 =
          OffsetDataList(data: [1, 2, 3, 4, 5], limit: 5, offset: 0, totalCount: 10);

      list1.merge(list2);

      expect(list3, list1);
    });
  }

  static void checkInvalidData() {
    test('checkInvalidData', () {
      OffsetDataList<int> list1 =
          OffsetDataList(data: [1, 2, 3], limit: 3, offset: 10, totalCount: 10);
      OffsetDataList<int> list2 =
          OffsetDataList(data: [4, 5], limit: 3, offset: 4, totalCount: 10);
      try {
        list1.merge(list2);
      } on IncompatibleRangesException catch (e) {
        expect(e.message, 'incorrect data range');
      }
    });
  }

  static void transformToStringDataList() {
    test('transformToStringDataList', () {
      OffsetDataList<int> intList =
          OffsetDataList(data: [1, 2, 3, 4, 5], limit: 5, offset: 0, totalCount: 5);
      OffsetDataList<String> stringList = intList.transform((i) => i.toString());

      OffsetDataList<String> expectedList = OffsetDataList(
          data: ["1", "2", "3", "4", "5"], limit: 5, offset: 0, totalCount: 5);
      expect(expectedList, stringList);
    });
  }

// map isn't implemented
/*   static void checkMapExtensionDataList() {
    test('checkMapExtensionDataList', () {
      DataList<int> intList =
          DataList(data: [1, 2, 3, 4, 5], limit: 5, offset: 0, totalCount: 5);
      DataList<String> stringList = intList.map((i) => i.toString());

      DataList<String> expectedList = DataList(
          data: ["1", "2", "3", "4", "5"], limit: 5, offset: 0, totalCount: 5);
      expect(expectedList, stringList);
    });
  } */

  static void checkFilterExtensionDataList() {
    test('checkFilterExtensionDataList', () {
      OffsetDataList<int> negativeList = OffsetDataList(
          data: [-1, -2, -3, -4, -5], limit: 5, offset: 0, totalCount: 5);
      OffsetDataList<int> filteredList = negativeList.where((i) => i > 0);

      OffsetDataList<int> emptyList = OffsetDataList<int>.empty();
      expect(emptyList.length, filteredList.length);
    });
  }

  static void checkDynamicDataInsertion() {
    test('checkDynamicDataInsertion', () {
      final element1 = Element(1);
      final element2 = Element(2);
      final element3 = Element(3);
      final element4 = Element(4);
      final element5 = Element(5);
      final element6 = Element(6);
      final element7 = Element(7);
      final element8 = Element(8);

      OffsetDataList<Element> list1 = OffsetDataList(
          data: [element1, element2, element3, element4, element5],
          limit: 5,
          offset: 4,
          totalCount: 20);

      OffsetDataList<Element> list2 = OffsetDataList(
          data: [element4, element5, element6, element7, element8],
          limit: 5,
          offset: 9,
          totalCount: 10);

      list1.mergeWithPredicate(list2, (element) => element.id);

      OffsetDataList<Element> list3 = OffsetDataList(data: [
        element1,
        element2,
        element3,
        element4,
        element5,
        element6,
        element7,
        element8
      ], limit: 10, offset: 4, totalCount: 20);
      expect(list3, list1);
    });
  }

  static void checkDynamicDataInsertion2() {
    test('checkDynamicDataInsertion2', () {
      final element1 = Element(1);
      final element2 = Element(2);
      final element3 = Element(3);
      final element4 = Element(4);
      final element5 = Element(5);
      final element6 = Element(6);
      final element7 = Element(7);

      OffsetDataList<Element> list1 = OffsetDataList(data: [
        element1,
        element2,
        element3,
        element4,
        element5,
        element6,
        element7
      ], limit: 7, offset: 6, totalCount: 30);

      OffsetDataList<Element> list2 = OffsetDataList(data: [
        element1,
        element2,
        element3,
        element4,
        element5,
        element6,
        element7
      ], limit: 7, offset: 13, totalCount: 30);

      OffsetDataList<Element> list3 = OffsetDataList(data: [
        element1,
        element2,
        element3,
        element4,
        element5,
        element6,
        element7
      ], limit: 7, offset: 20, totalCount: 30);

      list1.mergeWithPredicate(list2, (element) => element.id);
      list1.mergeWithPredicate(list3, (element) => element.id);

      OffsetDataList<Element> list4 = OffsetDataList(data: [
        element1,
        element2,
        element3,
        element4,
        element5,
        element6,
        element7
      ], limit: 21, offset: 6, totalCount: 30);

      expect(list1, list4);
    });
  }

  static void checkDynamicDataInsertion3() {
    test('checkDynamicDataInsertion3', () {
      final element0 = Element(0);
      final element1 = Element(1);
      final element2 = Element(2);
      final element3 = Element(3);
      final element4 = Element(4);
      final element5 = Element(5);
      final element6 = Element(6);
      final element7 = Element(7);
      final element8 = Element(8);
      final element9 = Element(9);

      OffsetDataList<Element> list1 = OffsetDataList(
          data: [element1, element2, element3, element4, element5],
          limit: 5,
          offset: 4,
          totalCount: 30);

      OffsetDataList<Element> list2 = OffsetDataList(
          data: [element0, element1, element2, element3, element4],
          limit: 5,
          offset: 9,
          totalCount: 30);

      OffsetDataList<Element> list3 = OffsetDataList(
          data: [element5, element6, element7, element8, element9],
          limit: 5,
          offset: 14,
          totalCount: 30);

      list1.mergeWithPredicate(list2, (element) => element.id);
      list1.mergeWithPredicate(list3, (element) => element.id);

      OffsetDataList<Element> list4 = OffsetDataList(data: [
        element1,
        element2,
        element3,
        element4,
        element5,
        element0,
        element6,
        element7,
        element8,
        element9
      ], limit: 15, offset: 4, totalCount: 30);

      expect(list1, list4);
    });
  }
}

class Element {
  final int id;

  Element(this.id);

  @override
  String toString() => "Element: $id";
}
