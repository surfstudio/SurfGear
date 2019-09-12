import 'dart:collection';
import 'dart:core';

import 'package:datalist/src/base/datalist.dart';
import 'package:datalist/src/exceptions.dart';

/// Pagination List
/// Page-count mechanism
/// May merge with another DataList
///
/// @param <T> Item
class PageCountDataList<T> extends DataList<T> {
  static const int UNSPECIFIED_PAGE = -1;
  static const int UNSPECIFIED_PAGE_SIZE = -1;
  static const int UNSPECIFIED_TOTAL_ITEMS_COUNT = -1;
  static const int UNSPECIFIED_TOTAL_PAGES_COUNT = -1;

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
  List<T> data;

  PageCountDataList({
    this.data,
    this.pageSize,
    this.startPage,
    this.numPages = 1,
    this.totalItemsCount = UNSPECIFIED_TOTAL_ITEMS_COUNT,
    this.totalPagesCount = UNSPECIFIED_TOTAL_PAGES_COUNT,
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
        startPage: UNSPECIFIED_PAGE,
        numPages: 0,
        pageSize: UNSPECIFIED_PAGE_SIZE,
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
        UNSPECIFIED_TOTAL_ITEMS_COUNT,
        UNSPECIFIED_TOTAL_PAGES_COUNT,
      );

  /// Merge two DataList
  ///
  /// @param inputDataList DataList for merge with current instance
  /// @return current instance
  @override
  PageCountDataList<T> merge(DataList<T> _inputDataList) {
    PageCountDataList inputDataList = _inputDataList as PageCountDataList;

    if (this.startPage != UNSPECIFIED_PAGE &&
        inputDataList.startPage != UNSPECIFIED_PAGE &&
        this.pageSize != inputDataList.pageSize) {
      throw new ArgumentError("pageSize for merging DataList must be same");
    }

    Map<int, List<T>> originalPagesData = _split();
    Map<int, List<T>> inputPagesData = inputDataList._split();
    SplayTreeMap<int, List<T>> resultPagesData = new SplayTreeMap();

    resultPagesData.addAll(originalPagesData);
    resultPagesData.addAll(inputPagesData);

    List<T> newData = List();
    int lastPage = UNSPECIFIED_PAGE;
    int lastPageItemsSize = UNSPECIFIED_PAGE_SIZE;

    resultPagesData.forEach((pageNumber, pageItems) {
      if (lastPage != UNSPECIFIED_PAGE &&
          (pageNumber - lastPage > 1 || lastPageItemsSize < pageSize)) {
        throw IncompatibleRangesException("Merging DataLists has empty space "
            "between its ranges\noriginalList:$this\ninputList: $inputDataList");
      }
      lastPage = pageNumber;
      lastPageItemsSize = pageItems.length;
      newData.addAll(pageItems);
    });
    this.data.clear();
    this.data.addAll(newData);
    this.startPage = resultPagesData.entries.first.key;
    this.numPages = lastPage - startPage + 1;
    this.totalItemsCount =
        inputDataList.totalItemsCount == UNSPECIFIED_TOTAL_ITEMS_COUNT
            ? this.totalItemsCount
            : inputDataList.totalItemsCount;
    this.totalPagesCount =
        inputDataList.totalPagesCount == UNSPECIFIED_TOTAL_PAGES_COUNT
            ? this.totalPagesCount
            : inputDataList.totalPagesCount;
    if (inputDataList.pageSize != UNSPECIFIED_PAGE_SIZE) {
      this.pageSize = inputDataList.pageSize;
    }
    return this;
  }

  /// Divides data into blocks by pages
  ///
  /// @return map of pages
  Map<int, List<T>> _split() {
    Map<int, List<T>> result = HashMap();
    for (int i = startPage; i < startPage + numPages; i++) {
      int startItemIndex = (i - startPage) * pageSize;
      int itemsRemained = data.length - startItemIndex;
      int endItemIndex = startItemIndex +
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
  PageCountDataList<R> transform<R>(R Function(T item) mapFunc) {
    List<R> resultData = List<R>();
    for (T item in this) {
      resultData.add(mapFunc.call(item));
    }
    return PageCountDataList(
      data: resultData,
      startPage: startPage,
      numPages: numPages,
      pageSize: pageSize,
      totalItemsCount: this.totalItemsCount,
      totalPagesCount: this.totalPagesCount,
    );
  }

  /// Checking the possibility of reloading data
  ///
  /// @return
  bool get canGetMore =>
      startPage == UNSPECIFIED_PAGE ||
      (data.length == (numPages - startPage + 1) * pageSize &&
          totalPagesCount != numPages);

  /// Returns the page value from which to start to load the next data block
  int get nextPage => startPage == UNSPECIFIED_PAGE ? 1 : startPage + numPages;

  /// Сброс данных
  /// Clear data
  @override
  void clear() {
    this.data.clear();
    startPage = UNSPECIFIED_PAGE;
    pageSize = UNSPECIFIED_PAGE_SIZE;
    numPages = 0;
    totalItemsCount = UNSPECIFIED_TOTAL_ITEMS_COUNT;
    totalPagesCount = UNSPECIFIED_TOTAL_PAGES_COUNT;
  }

  @override
  bool add(T t) {
    throw Exception("Unsupported operation \'add\'");
  }

  @override
  bool remove(Object o) {
    throw Exception("Unsupported operation \'remove\'");
  }

  @override
  void addAll(Iterable<T> iterable) {
    throw Exception("Unsupported operation \'addAll\'");
  }

  @override
  String toString() {
    return "DataList{"
        "pageSize=$pageSize"
        ", startPage=$startPage"
        ", numPages=$numPages"
        ", totalItemsCount=$totalItemsCount"
        ", totalPagesCount=$totalPagesCount"
        ", data=$data"
        '}';
  }
}
