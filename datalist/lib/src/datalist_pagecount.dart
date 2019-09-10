import 'dart:collection';
import 'dart:core';

import 'package:datalist/src/base/datalist.dart';
import 'package:datalist/src/exceptions.dart';

/// List для работы с пагинацией
/// Механизм page-count
/// Можно сливать с другим DataList
///
/// @param <T> Item
class PageCountDataList<T> extends DataList<T> {
  static const int UNSPECIFIED_PAGE = -1;
  static const int UNSPECIFIED_PAGE_SIZE = -1;
  static const int UNSPECIFIED_TOTAL_ITEMS_COUNT = -1;
  static const int UNSPECIFIED_TOTAL_PAGES_COUNT = -1;

  int pageSize;
  int startPage;
  int numPages;
  int totalItemsCount;
  int totalPagesCount;

  List<T> data;

  PageCountDataList({
    this.data,
    this.pageSize,
    this.startPage,
    this.numPages = 1,
    this.totalItemsCount = UNSPECIFIED_TOTAL_ITEMS_COUNT,
    this.totalPagesCount = UNSPECIFIED_TOTAL_PAGES_COUNT,
  }) : super(data);

  /// Создает пустой DataList
  ///
  /// @param <T>             тип данных в листе
  /// @param totalItemsCount максимальное количество элементов
  /// @param totalPagesCount максимальное количество страниц
  /// @return пустой дата-лист
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

  ///Создает пустой DataList
  ///
  /// @param <T> тип данных в листе
  /// @return пустой дата-лист
  factory PageCountDataList.empty() =>
      PageCountDataList.emptyWithTotalCount(0, 0);

  /// Создает пустой DataList
  ///
  /// @param <T> тип данных в листе
  /// @return пустой дата-лист
  factory PageCountDataList.emptyUnspecifiedTotal() =>
      PageCountDataList.emptyWithTotalCount(
        UNSPECIFIED_TOTAL_ITEMS_COUNT,
        UNSPECIFIED_TOTAL_PAGES_COUNT,
      );

  /// Слияние двух DataList
  ///
  /// @param inputDataList DataList для слияния с текущим
  /// @return текущий экземпляр
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
            "between its ranges, original list:$this, inputList: $inputDataList");
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

  /// разделяет данные на блоки по страницам
  ///
  /// @return
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

  /// Преобразует dataList одного типа в dataList другого типа
  ///
  /// @param mapFunc функция преобразования
  /// @param <R>     тип данных нового списка
  /// @return DataList с элементами типа R
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

  /// Проверка возможности дозагрузки данных
  ///
  /// @return
  bool get canGetMore =>
      startPage == UNSPECIFIED_PAGE ||
      (data.length == (numPages - startPage + 1) * pageSize &&
          totalPagesCount != numPages);

  /// возвращает значение page, c которого нужно начать чтобы подгрузить следующий блок данных
  int get nextPage => startPage == UNSPECIFIED_PAGE ? 1 : startPage + numPages;

  /// Сброс данных
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
