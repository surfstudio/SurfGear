# bottom_sheet

Custom bottom sheet widget, that can resize by drag and then scroll.

## Usage

Main classes:
1. [FlexibleBottomSheetController](lib/src/flexible_bottom_sheet_controller.dart)
2. [FlexibleBottomSheetOwner](lib/src/flexible_bottom_sheet_owner.dart)
3. [BottomSheetRoute and Showing method](lib/src/flexible_bottom_sheet_route.dart)

## Bottom Sheet

Flexible and scrollable bottom sheet.

You can show it if call `showFlexibleBottomSheet()`, then it will be show as popup like a modal
bottom sheet with resize by drag and scrollable.

Also you can use `FlexibleBottomSheetController` to show it.
For this call you must create `FlexibleBottomSheetController` and give to controller 