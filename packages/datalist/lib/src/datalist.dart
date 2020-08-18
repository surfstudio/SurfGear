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

import 'dart:core';

import 'package:collection/collection.dart';

/// Родительский List для работы с пагинацией
/// Можно сливать с другим DataList
///
/// Parent Pagination List
/// May merge with another DataList
///
/// @param <T> Item
abstract class DataList<T> extends DelegatingList<T> {
  DataList(this.data) : super(data);

  ///Download List
  List<T> data;

  /// Проверка возможности дозагрузки данных
  /// Checking the possibility of reloading data
  bool get canGetMore;

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
