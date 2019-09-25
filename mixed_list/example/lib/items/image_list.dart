import 'dart:core';

import 'package:collection/collection.dart';

class ImageList extends DelegatingList {
  List<String> data;

  ImageList(this.data) : super(data);
}
