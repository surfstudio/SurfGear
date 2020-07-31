import 'package:flutter/widgets.dart';

/// Mixin for register Flexible Bottom Sheet
mixin FlexibleBottomSheetOwner {
  Map<Object, BottomSheetShower> get registeredBottomSheetShowers;
}

/// Class represent data for bottom sheet building
abstract class BottomSheetData {}

class BottomSheetShower<T extends BottomSheetData, R> {
  BottomSheetShower(this.builder);

  final Future<R> Function(BuildContext context, {T data}) builder;

  Future<R> call(BuildContext context, {T data}) =>
      builder(context, data: data);
}
