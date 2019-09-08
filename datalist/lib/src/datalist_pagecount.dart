import 'dart:collection';
import 'dart:core';

import 'package:collection/collection.dart';
import 'package:datalist/datalist.dart';
import 'package:sortedmap/sortedmap.dart';

class DataList1<T> extends DelegatingList<T> {
  static final int UNSPECIFIED_PAGE = -1;
  static final int UNSPECIFIED_PAGE_SIZE = -1;
  static final int UNSPECIFIED_TOTAL_ITEMS_COUNT = -1;
  static final int UNSPECIFIED_TOTAL_PAGES_COUNT = -1;

  int pageSize;
  int startPage;
  int numPages;
  int totalItemsCount;
  int totalPagesCount;

  List<T> data;

  DataList1({
    this.data,
    this.pageSize,
    this.startPage,
    this.numPages,
    this.totalItemsCount,
    this.totalPagesCount,
  }) : super(data);

  /// Создает пустой DataList
  ///
  /// @param <T>             тип данных в листе
  /// @param totalItemsCount максимальное количество элементов
  /// @param totalPagesCount максимальное количество страниц
  /// @return пустой дата-лист
  factory DataList1.emptyWithTotalCount(
          int totalItemsCount, int totalPagesCount) =>
      DataList1(
        data: List(),
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
  factory DataList1.empty() => DataList1.emptyWithTotalCount(
        0,
        0,
      );

  /// Создает пустой DataList
  ///
  /// @param <T> тип данных в листе
  /// @return пустой дата-лист
  factory DataList1.emptyUnspecifiedTotal() => DataList1.emptyWithTotalCount(
        UNSPECIFIED_TOTAL_ITEMS_COUNT,
        UNSPECIFIED_TOTAL_PAGES_COUNT,
      );

  DataList1<T> merge(DataList1<T> inputDataList) {
    if (this.startPage != UNSPECIFIED_PAGE &&
        inputDataList.startPage != UNSPECIFIED_PAGE &&
        this.pageSize != inputDataList.pageSize) {
      throw ArgumentError("pageSize for merging DataList must be same");
    }
    Map<int, List<T>> originalPagesData = _split();
    Map<int, List<T>> inputPagesData = inputDataList._split();
    TreeMap<int, List<T>> resultPagesData = TreeMap();

    resultPagesData.addAll(originalPagesData);
    resultPagesData.addAll(inputPagesData);

    List<T> newData = List();
    int lastPage = UNSPECIFIED_PAGE;
    int lastPageItemsSize = UNSPECIFIED_PAGE_SIZE;

    resultPagesData.forEach((pageNumber, pageItems) {
      if (lastPage != UNSPECIFIED_PAGE &&
          (pageNumber - lastPage > 1 || lastPageItemsSize < pageSize)) {
        throw IncompatibleRangesException("Merging DataLists has empty space "
            "between its ranges, original list:  $this, inputList: $inputDataList");
      }
      lastPage = pageNumber;
      lastPageItemsSize = pageItems.length;
      newData.addAll(pageItems);
    });
    this.data = newData;
    this.startPage = resultPagesData.entries.first.key; //firstkey??
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

      result[i] = data.sublist(startItemIndex, endItemIndex);
    }
    return result;
  }

  /// Преобразует dataList одного типа в dataList другого типа
  ///
  /// @param mapFunc функция преобразования
  /// @param <R>     тип данных нового списка
  /// @return DataList с элементами типа R
  DataList1<R> transform<R>(R Function(T item) mapFunc) {
    List<R> resultData = List<R>();
    for (T item in this) {
      resultData.add(mapFunc.call(item));
    }
    return DataList1(
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


}
