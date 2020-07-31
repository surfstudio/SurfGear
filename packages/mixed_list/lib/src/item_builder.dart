import 'package:flutter/widgets.dart';

/// Builder by data base class.
// ignore: one_member_abstracts
abstract class ItemBuilder<T> {
  /// Create widget inside parent
  ///
  /// @param context context, to which widget will attach
  /// @param data item of widget
  Widget build(BuildContext context, T data);
}
