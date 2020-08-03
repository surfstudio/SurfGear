import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:bottom_sheet/src/flexible_bottom_sheet_owner.dart';
import 'package:flutter/material.dart';

/// Default controller of showing bottom sheet that can resize and scroll.
class FlexibleBottomSheetController {
  FlexibleBottomSheetController(
    this._context, {
    this.owner,
  });

  final BuildContext _context;
  final FlexibleBottomSheetOwner owner;

  /// Show registered bottom sheet.
  Future<T> show<T>(
    Object type, {
    BottomSheetData data,
  }) {
    return owner.registeredBottomSheetShowers[type](
      _context,
      data: data,
    ) as Future<T>;
  }
}
