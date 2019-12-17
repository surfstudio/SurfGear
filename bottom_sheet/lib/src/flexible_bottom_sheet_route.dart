import 'package:bottom_sheet/src/flexible_bottom_sheet.dart';
import 'package:bottom_sheet/src/widgets/flexible_draggable_scrollable_sheet.dart';
import 'package:flutter/material.dart';

const Duration _bottomSheetDuration = Duration(milliseconds: 500);

/// Shows a flexible bottom sheet.
///
/// anchors - relative height that bottom sheet can be
Future<T> showFlexibleBottomSheet<T>({
  @required BuildContext context,
  @required FlexibleDraggableScrollableWidgetBuilder builder,
  double minHeight,
  double initHeight,
  double maxHeight,
  bool isCollapsible = true,
  bool isExpand = true,
  bool useRootNavigator = false,
  bool isModal = true,
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
      minHeight: minHeight ?? 0,
      initHeight: initHeight ?? 0.5,
      maxHeight: maxHeight ?? 1,
      isCollapsible: isCollapsible,
      isExpand: isExpand,
      builder: builder,
      isModal: isModal,
      anchors: anchors,
    ),
  );
}

/// A modal route with flexible bottom sheet.
class _FlexibleBottomSheetRoute<T> extends PopupRoute<T> {
  final FlexibleDraggableScrollableWidgetBuilder builder;
  final double minHeight;
  final double initHeight;
  final double maxHeight;
  final bool isCollapsible;
  final bool isExpand;
  final bool isModal;
  final List<double> anchors;

  final ThemeData theme;

  _FlexibleBottomSheetRoute({
    this.minHeight,
    this.initHeight,
    this.maxHeight,
    this.builder,
    this.theme,
    this.barrierLabel,
    this.isCollapsible,
    this.isExpand,
    this.isModal,
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
  Color get barrierColor => isModal ? Colors.black54 : Color(0x00FFFFFF);

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
                initHeight: initHeight,
                maxHeight: maxHeight,
                builder: builder,
                isExpand: isExpand,
                animationController: _animationController,
                anchors: anchors,
              )
            : FlexibleBottomSheet(
                minHeight: minHeight,
                initHeight: initHeight,
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

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    var begin = Offset(0.0, 1.0);
    var end = Offset.zero;
    var curve = Curves.ease;
    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

    return SlideTransition(
      position: animation.drive(tween),
      child: super.buildTransitions(
        context,
        animation,
        secondaryAnimation,
        child,
      ),
    );
  }
}
