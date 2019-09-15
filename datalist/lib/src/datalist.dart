import 'dart:core';

import 'package:collection/collection.dart';

/// Родительский List для работы с пагинацией
/// Можно сливать с другим DataList
///
/// Parent Pagination List
/// May merge with another DataList
///
/// @param <T> Item
abstract class DataList<T> extends DelegatingList<T>{

  ///Download List
  List<T> data;

  /// Проверка возможности дозагрузки данных
  /// Checking the possibility of reloading data
  bool get canGetMore;

  DataList(this.data) : super(data);

  /// Слияние двух DataList
  /// Merge two DataList
  ///
  /// @param inputDataList DataList for merge with current instance
  /// @return current instance
  DataList<T> merge(DataList<T> data);

  /// Преобразует DataList одного типа в DataList другого типа
  /// Converts a DataList of one type to a DataList of another type
  ///
  /// @param mapFunc mapping function
  /// @param <R>     type of new list
  /// @return DataList<R>
  DataList<R> transform<R>(R Function(T item) mapFunc);

}