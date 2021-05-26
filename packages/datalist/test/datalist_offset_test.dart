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
import 'package:datalist/src/impl/datalist_limit_offset.dart';
import 'package:test/test.dart';

void main() {
  test('testCheckNormalMerge', () {
    final list1 = OffsetDataList(
      data: [1, 2, 3, 4, 5],
      limit: 5,
      totalCount: 10,
    );
    final list2 = OffsetDataList(
      data: [6, 7, 8, 9, 10],
      limit: 5,
      offset: 5,
      totalCount: 5,
    );
    final list3 = OffsetDataList(
      data: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
      limit: 10,
      totalCount: 10,
    );

    list1.merge(list2);
    expect(list3, equals(list1));
  });

  test('checkNormalMergeWithOffset', () {
    final list1 = OffsetDataList(
      data: [1, 2, 3, 4, 5],
      limit: 5,
      offset: 7,
      totalCount: 10,
    );
    final list2 = OffsetDataList(
      data: [6, 7, 8, 9, 10],
      limit: 5,
      offset: 12,
      totalCount: 10,
    );
    final list3 = OffsetDataList(
      data: [6, 7, 8, 9, 10],
      limit: 5,
      offset: 17,
      totalCount: 10,
    );
    final list4 = OffsetDataList(
      data: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 6, 7, 8, 9, 10],
      limit: 15,
      offset: 7,
      totalCount: 10,
    );

    list3..merge(list2)..merge(list1);
    expect(list3, equals(list4));
  });

  test('checkNormalMergeWithOffsetAndCollision', () {
    final list1 = OffsetDataList(
      data: [1, 2, 3, 4, 5],
      limit: 5,
      offset: 7,
      totalCount: 10,
    );
    final list2 = OffsetDataList(
      data: [6, 7, 8, 9, 10],
      limit: 5,
      offset: 12,
      totalCount: 10,
    );
    final list3 = OffsetDataList(
      data: [6, 7, 8, 9, 10],
      limit: 5,
      offset: 14,
      totalCount: 10,
    );
    final list4 = OffsetDataList(
      data: [1, 2, 3, 4, 5, 6, 7, 6, 7, 8, 9, 10],
      limit: 12,
      offset: 7,
      totalCount: 10,
    );

    list3..merge(list2)..merge(list1);
    expect(list3, equals(list4));
  });

  test('checkMergeWithCollision', () {
    final list1 = OffsetDataList(data: [1, 2, 3], limit: 3, totalCount: 10);
    final list2 = OffsetDataList(data: [6, 7], limit: 3, totalCount: 10);
    final list3 = OffsetDataList(data: [6, 7], limit: 3, totalCount: 10);

    list1.merge(list2);
    expect(list1, equals(list3));
  });

  test('checkMergeWithCollision2', () {
    final list1 = OffsetDataList(
      data: [1, 2, 3],
      limit: 3,
      offset: 2,
      totalCount: 10,
    );
    final list2 = OffsetDataList(
      data: [4, 5],
      limit: 3,
      offset: 4,
      totalCount: 10,
    );
    final list3 = OffsetDataList(
      data: [1, 2, 4, 5],
      limit: 5,
      offset: 2,
      totalCount: 10,
    );

    list1.merge(list2);
    expect(list1, equals(list3));
  });

  test('checkMergeWithCollision3', () {
    final list1 = OffsetDataList(
      data: [1, 2, 3, 4, 5],
      limit: 5,
      totalCount: 10,
    );
    final list2 = OffsetDataList(data: [6, 7], limit: 3, totalCount: 10);
    final list3 = OffsetDataList(data: [6, 7], limit: 3, totalCount: 10);

    list1.merge(list2);
    expect(list1, equals(list3));
  });

  test('checkMergeWithCollision4', () {
    final list1 = OffsetDataList(data: [6, 7], limit: 3, totalCount: 10);
    final list2 = OffsetDataList(
      data: [1, 2, 3, 4, 5],
      limit: 5,
      totalCount: 10,
    );
    final list3 = OffsetDataList(
      data: [1, 2, 3, 4, 5],
      limit: 5,
      totalCount: 10,
    );

    list1.merge(list2);
    expect(list1, equals(list3));
  });

  test('checkMergeEmptyWithNormal', () {
    final list1 = OffsetDataList<int>.empty();
    final list2 = OffsetDataList(
      data: [1, 2, 3, 4, 5],
      limit: 5,
      totalCount: 10,
    );
    final list3 = OffsetDataList(
      data: [1, 2, 3, 4, 5],
      limit: 5,
      totalCount: 10,
    );

    list1.merge(list2);
    expect(list3, equals(list1));
  });

  test('checkInvalidData', () {
    final list1 = OffsetDataList(
      data: [1, 2, 3],
      limit: 3,
      offset: 10,
      totalCount: 10,
    );
    final list2 = OffsetDataList(
      data: [4, 5],
      limit: 3,
      offset: 4,
      totalCount: 10,
    );

    try {
      list1.merge(list2);
    } on IncompatibleRangesException catch (e) {
      expect(e.message, equals('incorrect data range'));
    }
  });

  test('transformToStringDataList', () {
    final intList = OffsetDataList(
      data: [1, 2, 3, 4, 5],
      limit: 5,
      totalCount: 5,
    );
    final stringList = intList.transform((i) => i.toString());

    final expectedList = OffsetDataList(
      data: ['1', '2', '3', '4', '5'],
      limit: 5,
      totalCount: 5,
    );
    expect(expectedList, equals(stringList));
  });

  test('checkDynamicDataInsertion', () {
    const element1 = Element(1);
    const element2 = Element(2);
    const element3 = Element(3);
    const element4 = Element(4);
    const element5 = Element(5);
    const element6 = Element(6);
    const element7 = Element(7);
    const element8 = Element(8);

    final list1 = OffsetDataList(
      data: [element1, element2, element3, element4, element5],
      limit: 5,
      offset: 4,
      totalCount: 20,
    );

    final list2 = OffsetDataList(
      data: [element4, element5, element6, element7, element8],
      limit: 5,
      offset: 9,
      totalCount: 10,
    );

    list1.mergeWithPredicate(list2, (element) => element.id);

    final list3 = OffsetDataList(
      data: [
        element1,
        element2,
        element3,
        element4,
        element5,
        element6,
        element7,
        element8,
      ],
      limit: 10,
      offset: 4,
      totalCount: 20,
    );
    expect(list3, equals(list1));
  });

  test('checkDynamicDataInsertion2', () {
    const element1 = Element(1);
    const element2 = Element(2);
    const element3 = Element(3);
    const element4 = Element(4);
    const element5 = Element(5);
    const element6 = Element(6);
    const element7 = Element(7);

    final list1 = OffsetDataList(
      data: [
        element1,
        element2,
        element3,
        element4,
        element5,
        element6,
        element7,
      ],
      limit: 7,
      offset: 6,
      totalCount: 30,
    );

    final list2 = OffsetDataList(
      data: [
        element1,
        element2,
        element3,
        element4,
        element5,
        element6,
        element7,
      ],
      limit: 7,
      offset: 13,
      totalCount: 30,
    );

    final list3 = OffsetDataList(
      data: [
        element1,
        element2,
        element3,
        element4,
        element5,
        element6,
        element7,
      ],
      limit: 7,
      offset: 20,
      totalCount: 30,
    );

    list1
      ..mergeWithPredicate(list2, (element) => element.id)
      ..mergeWithPredicate(list3, (element) => element.id);

    final list4 = OffsetDataList(
      data: [
        element1,
        element2,
        element3,
        element4,
        element5,
        element6,
        element7,
      ],
      limit: 21,
      offset: 6,
      totalCount: 30,
    );

    expect(list1, equals(list4));
  });

  test('checkDynamicDataInsertion3', () {
    const element0 = Element(0);
    const element1 = Element(1);
    const element2 = Element(2);
    const element3 = Element(3);
    const element4 = Element(4);
    const element5 = Element(5);
    const element6 = Element(6);
    const element7 = Element(7);
    const element8 = Element(8);
    const element9 = Element(9);

    final list1 = OffsetDataList(
      data: [element1, element2, element3, element4, element5],
      limit: 5,
      offset: 4,
      totalCount: 30,
    );

    final list2 = OffsetDataList(
      data: [element0, element1, element2, element3, element4],
      limit: 5,
      offset: 9,
      totalCount: 30,
    );

    final list3 = OffsetDataList(
      data: [element5, element6, element7, element8, element9],
      limit: 5,
      offset: 14,
      totalCount: 30,
    );

    list1
      ..mergeWithPredicate(list2, (element) => element.id)
      ..mergeWithPredicate(list3, (element) => element.id);

    final list4 = OffsetDataList(
      data: [
        element1,
        element2,
        element3,
        element4,
        element5,
        element0,
        element6,
        element7,
        element8,
        element9,
      ],
      limit: 15,
      offset: 4,
      totalCount: 30,
    );

    expect(list1, equals(list4));
  });
}

class Element {
  const Element(this.id);

  final int id;

  @override
  String toString() => 'Element: $id';
}
