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

import 'dart:collection';

import 'package:datalist/src/datalist.dart';
import 'package:datalist/src/exceptions.dart';

/// Pagination List
/// Page-count mechanism
/// May merge with another DataList
class PageCountDataList<T> extends DataList<T> {
  PageCountDataList({
    required this.data,
    required this.pageSize,
    required this.startPage,
    this.numPages = 1,
    this.totalItemsCount = unspecifiedTotalItemsCount,
    this.totalPagesCount = unspecifiedTotalPagesCount,
  }) : super(data);

  /// Creating an empty DataList with a limit on the maximum number of elements
  ///
  /// [totalItemsCount] max count of items
  /// [totalPagesCount] max count of pages
  factory PageCountDataList.emptyWithTotalCount(
    int totalItemsCount,
    int totalPagesCount,
  ) =>
      PageCountDataList(
        data: [],
        startPage: unspecifiedPage,
        numPages: 0,
        pageSize: unspecifiedPageSize,
        totalPagesCount: totalPagesCount,
        totalItemsCount: totalItemsCount,
      );

  /// Create empty DataList
  factory PageCountDataList.empty() =>
      PageCountDataList.emptyWithTotalCount(0, 0);

  /// Create empty DataList
  factory PageCountDataList.emptyUnspecifiedTotal() =>
      PageCountDataList.emptyWithTotalCount(
        unspecifiedTotalItemsCount,
        unspecifiedTotalPagesCount,
      );

  static const int unspecifiedPage = -1;
  static const int unspecifiedPageSize = -1;
  static const int unspecifiedTotalItemsCount = -1;
  static const int unspecifiedTotalPagesCount = -1;

  /// Page size
  int pageSize;

  /// Which page begins
  int startPage;

  /// Page count
  int numPages;

  /// Max items count
  int totalItemsCount;

  /// Max pages count
  int totalPagesCount;

  /// List of items
  @override
  // ignore: overridden_fields
  List<T> data;

  /// Merge two DataList
  ///
  /// [_inputDataList] DataList for merge with current instance
  @override
  PageCountDataList<T> merge(DataList<T> _inputDataList) {
    final inputDataList = _inputDataList as PageCountDataList<T>;

    if (startPage != unspecifiedPage &&
        inputDataList.startPage != unspecifiedPage &&
        pageSize != inputDataList.pageSize) {
      throw ArgumentError('pageSize for merging DataList must be same');
    }

    final resultPagesData = SplayTreeMap<int, List<T>>()
      ..addAll(_split())
      ..addAll(inputDataList._split());

    final newData = <T>[];
    var lastPage = unspecifiedPage;
    var lastPageItemsSize = unspecifiedPageSize;

    resultPagesData.forEach((pageNumber, pageItems) {
      if (lastPage != unspecifiedPage &&
          (pageNumber - lastPage > 1 || lastPageItemsSize < pageSize)) {
        throw IncompatibleRangesException(
          'Merging DataLists has empty space '
          'between its ranges\noriginalList:$this\ninputList: $inputDataList',
        );
      }
      lastPage = pageNumber;
      lastPageItemsSize = pageItems.length;
      newData.addAll(pageItems);
    });

    data
      ..clear()
      ..addAll(newData);

    startPage = resultPagesData.entries.first.key;
    numPages = lastPage - startPage + 1;
    totalItemsCount =
        inputDataList.totalItemsCount == unspecifiedTotalItemsCount
            ? totalItemsCount
            : inputDataList.totalItemsCount;
    totalPagesCount =
        inputDataList.totalPagesCount == unspecifiedTotalPagesCount
            ? totalPagesCount
            : inputDataList.totalPagesCount;

    if (inputDataList.pageSize != unspecifiedPageSize) {
      pageSize = inputDataList.pageSize;
    }

    return this;
  }

  /// Divides data into blocks by pages
  Map<int, List<T>> _split() {
    final result = <int, List<T>>{};

    for (var i = startPage; i < startPage + numPages; i++) {
      final startItemIndex = (i - startPage) * pageSize;
      final itemsRemained = data.length - startItemIndex;
      final endItemIndex = startItemIndex +
          (itemsRemained < pageSize ? itemsRemained : pageSize);
      if (itemsRemained <= 0) {
        break;
      }

      result.putIfAbsent(i, () => data.sublist(startItemIndex, endItemIndex));
    }

    return result;
  }

  /// Converts a DataList of one type to a DataList of another type
  ///
  /// [mapFunc] mapping function
  @override
  PageCountDataList<R> transform<R>(R Function(T item) mapFunc) =>
      PageCountDataList(
        data: map(mapFunc.call).toList(),
        startPage: startPage,
        numPages: numPages,
        pageSize: pageSize,
        totalItemsCount: totalItemsCount,
        totalPagesCount: totalPagesCount,
      );

  /// Checking the possibility of reloading data
  @override
  bool get canGetMore =>
      startPage == unspecifiedPage ||
      (data.length == (numPages - startPage + 1) * pageSize &&
          totalPagesCount != numPages);

  /// Returns the page value from which to start to load the next data block
  int get nextPage => startPage == unspecifiedPage ? 1 : startPage + numPages;

  /// Clear data
  @override
  void clear() {
    data.clear();
    startPage = unspecifiedPage;
    pageSize = unspecifiedPageSize;
    numPages = 0;
    totalItemsCount = unspecifiedTotalItemsCount;
    totalPagesCount = unspecifiedTotalPagesCount;
  }

  @override
  bool add(T value) {
    throw Exception("Unsupported operation 'add'");
  }

  @override
  bool remove(Object? value) {
    throw Exception("Unsupported operation 'remove'");
  }

  @override
  void addAll(Iterable<T> iterable) {
    throw Exception("Unsupported operation 'addAll'");
  }

  @override
  String toString() {
    return 'DataList{'
        'pageSize=$pageSize, '
        'startPage=$startPage, '
        'numPages=$numPages, '
        'totalItemsCount=$totalItemsCount, '
        'totalPagesCount=$totalPagesCount, '
        'data=$data'
        '}';
  }
}
