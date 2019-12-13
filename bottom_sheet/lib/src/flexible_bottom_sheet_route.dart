import 'package:bottom_sheet/src/flexible_bottom_sheet.dart';
import 'package:flutter/material.dart';

const Duration _bottomSheetDuration = Duration(milliseconds: 200);

/// Shows a flexible bottom sheet.
///
/// anchors - relative height that bottom sheet can be
Future<T> showFlexibleBottomSheet<T>({
  @required BuildContext context,
  @required ScrollableWidgetBuilder builder,
  double minHeight,
  double minPartHeight,
  double maxHeight,
  double maxPartHeight,
  bool isCollapsible = true,
  bool isExpand = true,
  bool useRootNavigator = false,
  List<double> anchors,
}) {
  assert(context != null);
  assert(builder != null);
  assert(useRootNavigator != null);
  assert(debugCheckHasMediaQuery(context));
  assert(debugCheckHasMaterialLocalizations(context));

  return Navigator.of(context, rootNavigator: useRootNavigator).push(
    _FlexibleBottomSheetRoute<T>(
      theme: Theme.of(context, shadowThemeOnly: true),
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      minHeight: minHeight,
      maxHeight: maxHeight,
      minPartHeight: minPartHeight,
      maxPartHeight: maxPartHeight,
      isCollapsible: isCollapsible,
      isExpand: isExpand,
      builder: builder,
      anchors: anchors,
    ),
  );
}

/// A modal route with flexible bottom sheet.
class _FlexibleBottomSheetRoute<T> extends PopupRoute<T> {
  final ScrollableWidgetBuilder builder;
  final double minHeight;
  final double minPartHeight;
  final double maxHeight;
  final double maxPartHeight;
  final bool isCollapsible;
  final bool isExpand;
  final List<double> anchors;

  final ThemeData theme;

  _FlexibleBottomSheetRoute({
    this.minHeight,
    this.minPartHeight,
    this.maxHeight,
    this.maxPartHeight,
    this.builder,
    this.theme,
    this.barrierLabel,
    this.isCollapsible,
    this.isExpand,
    this.anchors,
    RouteSettings settings,
  }) : super(settings: settings);

  @override
  Duration get transitionDuration => _bottomSheetDuration;

  @override
  bool get barrierDismissible => true;

  @override
  final String barrierLabel;

  @override
  Color get barrierColor => Colors.black54;

  AnimationController _animationController;

  @override
  AnimationController createAnimationController() {
    assert(_animationController == null);
    _animationController = AnimationController(
      duration: _bottomSheetDuration,
      debugLabel: 'FlexibleBottomSheet',
      vsync: navigator.overlay,
    );

    return _animationController;
  }

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    Widget bottomSheet = MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: isCollapsible
            ? FlexibleBottomSheet.collapsible(
                maxPartHeight: maxPartHeight,
                maxHeight: maxHeight,
                builder: builder,
                isExpand: isExpand,
                animationController: _animationController,
                anchors: anchors,
              )
            : FlexibleBottomSheet(
                minPartHeight: minPartHeight,
                maxPartHeight: maxPartHeight,
                minHeight: minHeight,
                maxHeight: maxHeight,
                builder: builder,
                isExpand: isExpand,
                animationController: _animationController,
                anchors: anchors,
              ));

    if (theme != null) {
      bottomSheet = Theme(data: theme, child: bottomSheet);
    }

    return bottomSheet;
  }
}
