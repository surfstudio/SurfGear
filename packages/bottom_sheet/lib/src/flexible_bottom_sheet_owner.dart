import 'package:bottom_sheet/src/widgets/flexible_draggable_scrollable_sheet.dart';

/// Mixin for register Flexible Bottom Sheet
mixin FlexibleBottomSheetOwner {
  Map<dynamic, FlexibleDraggableScrollableWidgetBuilder>
      get registeredBottomSheet;
}
