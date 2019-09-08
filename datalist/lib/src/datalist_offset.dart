import 'dart:collection';
import 'dart:core';

import 'package:collection/collection.dart';
import 'package:datalist/src/exceptions.dart';

/// List для работы с пагинацией
/// Механизм limit-offset
/// Можно сливать с другим DataList
///
/// @param <T> Item

class DataList<T> extends DelegatingList<T> {
  //количество элементов в списке
  int limit;

  //сдвиг относительно первого элемента
  int offset;

  //максимально возможное количество эелементов списка
  int totalCount;

  List<T> data;

  factory DataList.empty() {
    return new DataList<T>(data: List<T>());
  }

  DataList<T> emptyWithTotal(int totalCount) {
    return new DataList(data: List<T>(), totalCount: totalCount);
  }

  DataList({
    this.data,
    this.limit = 0,
    this.offset = 0,
    this.totalCount = 0,
  }) : super(data);

  /// Слияние двух DataList
  ///
  /// @param data DataList для слияния с текущим
  /// @return текущий экземпляр
  DataList<T> merge(DataList<T> data) {
    bool reverse = data.offset < this.offset;
    List<T> merged = tryMerge(reverse ? data : this, reverse ? this : data);
    if (merged == null) {
      //Отрезки данных не совпадают, слияние не возможно
      throw IncompatibleRangesException("incorrect data range");
    }
    this.data.clear();
    this.data.addAll(merged);
    if (this.offset < data.offset) {
      //загрузка вниз, как обычно
      this.limit = data.offset + data.limit - this.offset;
    } else if (this.offset == data.offset) {
      //коллизия?
      this.limit = data.limit;
    } else {
      // загрузка вверх
      this.offset = data.offset;
      this.limit = length;
    }

    this.totalCount = data.totalCount;
    return this;
  }

  /// Слияние двух DataList с удалением дублируемых элементов
  /// При удалении остаются актуальные (последние присланные сервером) элементы
  ///
  /// @param data              DataList для слияния с текущим
  /// @param distinctPredicate предикат, по которому происходит удаление дублируемых элементов
  /// @return текущий экземпляр
  DataList<T> mergeWithPredicate<R>(
    DataList<T> data,
    R Function(T item) distinctPredicate,
  ) {
    bool reverse = data.offset < this.offset;
    List<T> merged = tryMerge(reverse ? data : this, reverse ? this : data);
    if (merged == null) {
      //Отрезки данных не совпадают, слияние не возможно
      throw new IncompatibleRangesException("incorrect data range");
    }

    List<T> filtered = distinctByLast(merged, distinctPredicate);
    this.data.clear();
    this.data.addAll(filtered);
    if (this.offset < data.offset) {
      //загрузка вниз, как обычно
      this.limit = data.offset + data.limit - this.offset;
    } else if (this.offset == data.offset) {
      //коллизия?
      this.limit = data.limit;
    } else {
      // загрузка вверх
      this.offset = data.offset;
      this.limit = length;
    }

    this.totalCount = data.totalCount;
    return this;
  }

  /// Преобразует dataList одного типа в dataList другого типа
  ///
  /// @param mapFunc функция преобразования
  /// @param <R>     тип данных нового списка
  /// @return DataList с элементами типа R
  DataList<R> transform<R>(R Function(T item) mapFunc) {
    List<R> resultData = new List();
    for (T item in this) {
      resultData.add(mapFunc.call(item));
    }

    return DataList<R>(
      data: resultData,
      limit: limit,
      offset: offset,
      totalCount: totalCount,
    );
  }

  /// возвращает значение offset c которого нужно начать чтобы подгрузить слкдующий блок данных
  int get nextOffset => limit + offset;

  int getLimit() {
    return limit;
  }

  int getOffset() {
    return offset;
  }

  int getTotalCount() {
    return totalCount;
  }

  /// Проверка возможности дозагрузки данных
  ///
  /// @return
  bool canGetMore() => totalCount > limit + offset;

  List<T> tryMerge(DataList<T> to, DataList<T> from) {
    if ((to.offset + to.limit) >= from.offset) {
      return mergeLists(to.data, from.data, from.offset - to.offset);
    }

    return null;
  }

  List<T> mergeLists(List<T> to, List<T> from, int start) {
    List<T> result = new List();
    result.addAll(start < to.length ? to.sublist(0, start) : to);
    result.addAll(from);
    return result;
  }

  @override
  bool add(T t) {
    throw Exception("Unsupported operation \'add\'");
  }

  @override
  bool remove(Object o) {
    throw Exception("Unsupported operation \'remove\'");
  }

  bool containsAll(Iterable<dynamic> another) {
    bool contains = false;
    for (var c in another) {
      contains = data.contains(c);
    }

    return contains;
  }

  @override
  void addAll(Iterable<T> iterable) {
    throw Exception("Unsupported operation \'addAll\'");
  }

  @override
  void clear() {
    super.clear();
    limit = 0;
    offset = 0;
  }

  @override
  List<T> sublist(int start, [int end]) {
    throw new Exception("Unsupported operation \'sublist\'");
  }

  @override
  String toString() {
    return "DataList {limit= $limit , offset= $offset , data= $data }";
  }

  /// Удаление одинаковых элементов из исходного списка
  /// Критерий того, что элементы одинаковые, задается параметром distinctPredicate
  ///
  /// @param source            исходный список
  /// @param distinctPredicate критерий того, что элементы одинаковые
  /// @return отфильтрованный список без одинаковых элементов
  List<T> distinctByLast<R>(
    List<T> source,
    R Function(T item) distinctPredicate,
  ) {
    LinkedHashMap<R, T> resultSet = LinkedHashMap<R, T>.of({});

    for (T element in source) {
      R key = distinctPredicate.call(element);
      resultSet[key] = element;
    }

    return resultSet.values.toList();
  }
}
