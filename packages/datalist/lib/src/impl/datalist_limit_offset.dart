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

import 'package:datalist/src/datalist.dart';
import 'package:datalist/src/exceptions.dart';

/// Pagination List
/// Limit-offset mechanism
/// May merge with another DataList
class OffsetDataList<T> extends DataList<T> {
  OffsetDataList({
    required this.data,
    this.limit = 0,
    this.offset = 0,
    this.totalCount = 0,
  }) : super(data);

  /// Creating an Empty DataList
  factory OffsetDataList.empty() {
    return OffsetDataList<T>(data: []);
  }

  /// Creating an empty DataList with a limit on the maximum number of elements
  factory OffsetDataList.emptyWithTotal(int totalCount) {
    return OffsetDataList(data: [], totalCount: totalCount);
  }

  /// Item count in List
  int limit;

  /// Offset relative to the first element
  int offset;

  /// Maximum number of list items
  int totalCount;

  /// List of items
  @override
  // ignore: overridden_fields
  List<T> data;

  /// Merge two DataList
  ///
  /// [_data] DataList for merge with current
  @override
  DataList<T> merge(DataList<T> _data) {
    final data = _data as OffsetDataList<T>;

    final reverse = data.offset < offset;
    final merged = _tryMerge(reverse ? data : this, reverse ? this : data);
    if (merged == null) {
      //Отрезки данных не совпадают, слияние не возможно
      throw IncompatibleRangesException('incorrect data range');
    }

    this.data
      ..clear()
      ..addAll(merged);

    if (offset < data.offset) {
      limit = data.offset + data.limit - offset;
    } else if (offset == data.offset) {
      limit = data.limit;
    } else {
      offset = data.offset;
      limit = length;
    }

    totalCount = data.totalCount;
    return this;
  }

  /// Merging two DataList with removing duplicate items
  /// When you delete, the current (last sent by the server) items remain
  ///
  /// [data] data list for merge with current
  /// [distinctPredicate] predicate by which duplicate elements are deleted
  // ignore: avoid_returning_this
  OffsetDataList<T> mergeWithPredicate<R>(
    OffsetDataList<T> data,
    R Function(T item) distinctPredicate,
  ) {
    final reverse = data.offset < offset;
    final merged = _tryMerge(reverse ? data : this, reverse ? this : data);
    if (merged == null) {
      throw IncompatibleRangesException('incorrect data range');
    }

    this.data
      ..clear()
      ..addAll(distinctByLast(merged, distinctPredicate));

    if (offset < data.offset) {
      //загрузка вниз, как обычно
      limit = data.offset + data.limit - offset;
    } else if (offset == data.offset) {
      //коллизия?
      limit = data.limit;
    } else {
      // загрузка вверх
      offset = data.offset;
      limit = length;
    }

    totalCount = data.totalCount;
    return this;
  }

  /// Converts a dataList of one type to a dataList of another type
  ///
  /// [mapFunc] mapping function
  @override
  OffsetDataList<R> transform<R>(R Function(T item) mapFunc) =>
      OffsetDataList<R>(
        data: map(mapFunc.call).toList(),
        limit: limit,
        offset: offset,
        totalCount: totalCount,
      );

  /// Returns the offset value from which you need to start to load the next
  /// data block
  int get nextOffset => limit + offset;

  int getLimit() => limit;

  int getOffset() => offset;

  int getTotalCount() => totalCount;

  /// Checking the possibility of reloading data
  @override
  bool get canGetMore => totalCount > limit + offset;

  List<T>? _tryMerge(OffsetDataList<T> to, OffsetDataList<T> from) {
    if ((to.offset + to.limit) >= from.offset) {
      return _mergeLists(to.data, from.data, from.offset - to.offset);
    }

    return null;
  }

  List<T> _mergeLists(List<T> to, List<T> from, int start) => [
        ...start < to.length ? to.sublist(0, start) : to,
        ...from,
      ];

  @override
  bool add(T value) {
    throw Exception("Unsupported operation 'add'");
  }

  @override
  bool remove(Object? value) {
    throw Exception("Unsupported operation 'remove'");
  }

  bool containsAll(Iterable<Object?> another) =>
      another.every((item) => data.contains(item));

  @override
  void addAll(Iterable<T> iterable) {
    throw Exception("Unsupported operation 'addAll'");
  }

  @override
  void clear() {
    super.clear();

    limit = 0;
    offset = 0;
  }

  @override
  List<T> sublist(int start, [int? end]) {
    throw Exception("Unsupported operation 'sublist'");
  }

  @override
  String toString() {
    return 'DataList {limit= $limit , offset= $offset , data= $data }';
  }

  /// Removing duplicate items from source list
  /// The criterion that the elements are the same is set by the
  /// distinctPredicate parameter
  ///
  /// [source] source list
  /// [distinctPredicate] criterion that the elements are the same
  List<T> distinctByLast<R>(List<T> source, R Function(T) distinctPredicate) {
    final resultSet = <R, T>{};

    for (final element in source) {
      resultSet[distinctPredicate.call(element)] = element;
    }

    return resultSet.values.toList();
  }
}
