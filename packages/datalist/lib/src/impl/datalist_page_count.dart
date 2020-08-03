import 'dart:collection';
import 'dart:core';

import 'package:datalist/src/datalist.dart';
import 'package:datalist/src/exceptions.dart';

/// Pagination List
/// Page-count mechanism
/// May merge with another DataList
///
/// @param <T> Item
class PageCountDataList<T> extends DataList<T> {
  PageCountDataList({
    this.data,
    this.pageSize,
    this.startPage,
    this.numPages = 1,
    this.totalItemsCount = unspecifiedTotalItemsCount,
    this.totalPagesCount = unspecifiedTotalPagesCount,
  }) : super(data);

  /// Creating an empty DataList with a limit on the maximum number of elements
  ///
  /// @param <T>             data type in List
  /// @param totalItemsCount max count of items
  /// @param totalPagesCount max count of pages
  /// @return empty DataList
  factory PageCountDataList.emptyWithTotalCount(
          int totalItemsCount, int totalPagesCount) =>
      PageCountDataList(
        data: [],
        startPage: unspecifiedPage,
        numPages: 0,
        pageSize: unspecifiedPageSize,
        totalPagesCount: totalPagesCount,
        totalItemsCount: totalItemsCount,
      );

  ///Create empty DataList
  ///
  /// @param <T> тип данных в листе
  /// @return пустой дата-лист
  factory PageCountDataList.empty() =>
      PageCountDataList.emptyWithTotalCount(0, 0);

  /// Create empty DataList
  ///
  /// @param <T> data type in list
  /// @return empty data list
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
  /// @param inputDataList DataList for merge with current instance
  /// @return current instance
  @override
  PageCountDataList<T> merge(DataList<T> _inputDataList) {
    final PageCountDataList inputDataList = _inputDataList as PageCountDataList;

    if (startPage != unspecifiedPage &&
        inputDataList.startPage != unspecifiedPage &&
        pageSize != inputDataList.pageSize) {
      throw ArgumentError('pageSize for merging DataList must be same');
    }

    final Map<int, List<T>> originalPagesData = _split();
    final Map<int, List<T>> inputPagesData =
        inputDataList._split().cast<int, List<T>>();
    final SplayTreeMap<int, List<T>> resultPagesData = SplayTreeMap()
      ..addAll(originalPagesData)
      ..addAll(inputPagesData);

    final List<T> newData = [];
    int lastPage = unspecifiedPage;
    int lastPageItemsSize = unspecifiedPageSize;

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
    data.clear();
    // ignore: cascade_invocations
    data.addAll(newData);
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
  ///
  /// @return map of pages
  Map<int, List<T>> _split() {
    final Map<int, List<T>> result = HashMap();
    for (int i = startPage; i < startPage + numPages; i++) {
      final int startItemIndex = (i - startPage) * pageSize;
      final int itemsRemained = data.length - startItemIndex;
      final int endItemIndex = startItemIndex +
          (itemsRemained < pageSize ? itemsRemained : pageSize);
      if (itemsRemained <= 0) break;

      result.putIfAbsent(i, () => data.sublist(startItemIndex, endItemIndex));
    }
    return result;
  }

  /// Converts a DataList of one type to a DataList of another type
  ///
  /// @param mapFunc mapping function
  /// @param <R>     type of new list
  /// @return DataList<R>
  @override
  PageCountDataList<R> transform<R>(R Function(T item) mapFunc) {
    final List<R> resultData = <R>[];
    for (final T item in this) {
      resultData.add(mapFunc.call(item));
    }
    return PageCountDataList(
      data: resultData,
      startPage: startPage,
      numPages: numPages,
      pageSize: pageSize,
      totalItemsCount: totalItemsCount,
      totalPagesCount: totalPagesCount,
    );
  }

  /// Checking the possibility of reloading data
  ///
  /// @return
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
  bool remove(Object value) {
    throw Exception("Unsupported operation 'remove'");
  }

  @override
  void addAll(Iterable<T> iterable) {
    throw Exception("Unsupported operation 'addAll'");
  }

  @override
  String toString() {
    return 'DataList{'
        'pageSize=$pageSize'
        ', startPage=$startPage'
        ', numPages=$numPages'
        ', totalItemsCount=$totalItemsCount'
        ', totalPagesCount=$totalPagesCount'
        ', data=$data'
        '}';
  }
}
