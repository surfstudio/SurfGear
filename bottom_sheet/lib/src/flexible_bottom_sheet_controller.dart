import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:bottom_sheet/src/flexible_bottom_sheet_owner.dart';
import 'package:flutter/material.dart';

/// Default controller of showing bottom sheet that can resize and scroll.
class FlexibleBottomSheetController {
  final BuildContext _context;
  final FlexibleBottomSheetOwner owner;

  FlexibleBottomSheetController.from(this._context, {this.owner});

  BuildContext get _scaffoldContext => Scaffold.of(_context).context;

  /// Show registered bottom sheet.
  Future<T> show<T>(type, {
    double maxHeight,
    double maxPartHeight,
  }) {
    return showFlexibleBottomSheet(
      context: _scaffoldContext,
      maxPartHeight: maxPartHeight,
      maxHeight: maxHeight,
      isExpand: true,
      isCollapsible: true,
      builder: owner?.registeredBottomSheet[type],
    );
  }
}
