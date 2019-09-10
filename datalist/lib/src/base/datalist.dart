import 'dart:core';

import 'package:collection/collection.dart';

abstract class DataList<T> extends DelegatingList<T>{

  List<T> data;

  bool get canGetMore;

  DataList(this.data) : super(data);

  DataList<T> merge(DataList<T> data);

  DataList<R> transform<R>(R Function(T item) mapFunc);

}