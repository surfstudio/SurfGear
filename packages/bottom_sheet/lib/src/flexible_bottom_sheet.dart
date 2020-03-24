import 'dart:math';

import 'package:bottom_sheet/src/widgets/flexible_bottom_sheet_scroll_notifyer.dart';
import 'package:bottom_sheet/src/widgets/flexible_draggable_scrollable_sheet.dart';
import 'package:flutter/material.dart';

/// Flexible and scrollable bottom sheet.
///
/// This bottom sheet resizing between min and max size, and when size become
/// max start scrolling content. Reduction size available when content
/// scrolled to 0 offset.
///
/// [minHeight], [maxHeight] are limits of
/// bounds this widget. For example:
/// - you can set  [maxHeight] to 1;
/// - you can set [minHeight] to 0.5;
///
/// [isCollapsible] make possible collapse widget and remove from the screen,
/// but you must be carefully to use it, set it to true only if you show this
/// widget with like showFlexibleBottomSheet() case, because it will be removed
/// by Navigator.pop(). If you set [isCollapsible] true, [minHeight]
/// must be 0.
///
/// The [animationController] that controls the bottom sheet's entrance and
/// exit animations.
/// The FlexibleBottomSheet widget will manipulate the position of this
/// animation, it is not just a passive observer.
///
/// [initHeight] - relevant height for init bottom sheet
class FlexibleBottomSheet extends StatefulWidget {
  final double minHeight;
  final double initHeight;
  final double maxHeight;
  final FlexibleDraggableScrollableWidgetBuilder builder;
  final FlexibleDraggableScrollableHeaderWidgetBuilder headerBuilder;
  final FlexibleDraggableScrollableWidgetBodyBuilder bodyBuilder;
  final bool isCollapsible;
  final bool isExpand;
  final AnimationController animationController;
  final List<double> anchors;
  final double minHeaderHeight;
  final double maxHeaderHeight;
  final Decoration decoration;
  final VoidCallback onDismiss;

  const FlexibleBottomSheet(
      {Key key,
      this.minHeight = 0,
      this.initHeight = 0.5,
      this.maxHeight = 1,
      this.builder,
      this.headerBuilder,
      this.bodyBuilder,
      this.isCollapsible = false,
      this.isExpand = true,
      this.animationController,
      this.anchors,
      this.minHeaderHeight,
      this.maxHeaderHeight,
      this.decoration,
      this.onDismiss})
      : assert(minHeight == null || minHeight >= 0 && minHeight <= 1),
        assert(maxHeight == null || maxHeight > 0 && maxHeight <= 1),
        assert(
            !(maxHeight != null && minHeight != null) || maxHeight > minHeight),
        assert(!isCollapsible || minHeight == 0),
        super(key: key);

  const FlexibleBottomSheet.collapsible({
    Key key,
    double initHeight = 0.5,
    double maxHeight = 1,
    FlexibleDraggableScrollableWidgetBuilder builder,
    FlexibleDraggableScrollableHeaderWidgetBuilder headerBuilder,
    FlexibleDraggableScrollableWidgetBodyBuilder bodyBuilder,
    bool isExpand,
    AnimationController animationController,
    List<double> anchors,
    double minHeaderHeight,
    double maxHeaderHeight,
    Decoration decoration,
  }) : this(
          maxHeight: maxHeight,
          builder: builder,
          headerBuilder: headerBuilder,
          bodyBuilder: bodyBuilder,
          minHeight: 0,
          initHeight: initHeight,
          isCollapsible: true,
          isExpand: isExpand,
          animationController: animationController,
          anchors: anchors,
          minHeaderHeight: minHeaderHeight,
          maxHeaderHeight: maxHeaderHeight,
          decoration: decoration,
        );

  @override
  _FlexibleBottomSheetState createState() => _FlexibleBottomSheetState();
}

class _FlexibleBottomSheetState extends State<FlexibleBottomSheet>
    with SingleTickerProviderStateMixin {
  bool _isClosing = false;

  AnimationController _animationController;
  final _topOffsetTween = Tween<double>();

  double _currentAnchor;

  FlexibleDraggableScrollableSheetScrollController _controller;

  bool _isKeyboardOpenedNotified = false;
  bool _isKeyboardClosedNotified = false;

  double get _currentExtent => _controller.extent.currentExtent;

  bool get _isDefaultBuilder => widget.builder != null;

  @override
  void initState() {
    super.initState();

    _currentAnchor = widget.initHeight;

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    final curve = CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    );
    Animation topTweenAnimation = _topOffsetTween.animate(curve);
    topTweenAnimation.addListener(() {
      if (_animationController.isAnimating) {
        _controller.extent.currentExtent = topTweenAnimation.value;
      }
    });
    topTweenAnimation.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        _controller.extent.currentExtent = _currentAnchor;
        _animationController.reset();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _checkKeyboard();

    return FlexibleScrollNotifyer(
      scrollStartCallback: _startScroll,
      scrollingCallback: _scrolling,
      scrollEndCallback: _endScroll,
      child: FlexibleDraggableScrollableSheet(
        maxChildSize: widget.maxHeight,
        minChildSize: widget.minHeight,
        initialChildSize: widget.initHeight,
        builder: (
          context,
          ScrollController controller,
        ) {
          _controller =
              controller as FlexibleDraggableScrollableSheetScrollController;

          return AnimatedPadding(
            duration: Duration(milliseconds: 100),
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: _buildContent(context),
          );
        },
        expand: widget.isExpand,
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (_isDefaultBuilder) {
      return widget.builder(
        context,
        _controller,
        _controller.extent.currentExtent,
      );
    }

    return Material(
      type: MaterialType.transparency,
      child: Container(
        decoration: widget.decoration,
        child: CustomScrollView(
          controller: _controller,
          slivers: <Widget>[
            if (widget.headerBuilder != null)
              SliverPersistentHeader(
                pinned: true,
                delegate: FlexibleBottomSheetHeaderDelegate(
                  minHeight: widget.minHeaderHeight,
                  maxHeight: widget.maxHeaderHeight,
                  child: widget.headerBuilder(context, _currentExtent),
                ),
              ),
            SliverList(
              delegate: widget.bodyBuilder(
                context,
                _currentExtent,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  void _checkKeyboard() {
    if (MediaQuery.of(context).viewInsets.bottom != 0) {
      if (!_isKeyboardOpenedNotified) {
        _isKeyboardOpenedNotified = true;
        _isKeyboardClosedNotified = false;
        _keyboardOpened();
      }
    } else {
      if (_isKeyboardOpenedNotified && !_isKeyboardClosedNotified) {
        _isKeyboardClosedNotified = true;
        _isKeyboardOpenedNotified = false;
        _keyboardClosed();
      }
    }
  }

  void _keyboardOpened() {
    double maxBottomSheetHeight = widget.maxHeight != null
        ? widget.maxHeight
        : _screenAnchors.reduce(max);

    _currentAnchor = maxBottomSheetHeight;
    _animateToNextAnchor(maxBottomSheetHeight);
    if (_currentAnchor == widget.maxHeight) {
      _preScroll();
    }
  }

  void _keyboardClosed() {}

  void _preScroll() {
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    if (_controller.extent.currentExtent == widget.maxHeight &&
        keyboardHeight != 0) {
      double widgetOffset = FocusManager.instance.primaryFocus.offset.dy;
      double widgetHeight = FocusManager.instance.primaryFocus.size.height;
      double screenHeight = MediaQuery.of(context).size.height;

      double valueToScroll =
          keyboardHeight - (screenHeight - (widgetOffset + widgetHeight));
      if (valueToScroll > 0) {
        Future.delayed(Duration(milliseconds: 100)).then((_) {
          _controller.animateTo(
            _controller.offset + valueToScroll + 10,
            duration: Duration(milliseconds: 200),
            curve: Curves.linear,
          );
        });
      }
    }
  }

  bool _startScroll(ScrollStartNotification notification) {
    return false;
  }

  bool _scrolling(FlexibleDraggableScrollableNotification notification) {
    if (_isClosing) return false;

    if (widget.isCollapsible && !_isClosing) {
      if (notification.extent == widget.minHeight) {
        setState(() {
          _isClosing = true;
          _dismiss();
        });
      }
    }

    var currentVal = notification.extent;
    var initVal = notification.initialExtent;

    if (initVal == 0) {
      initVal = currentVal;
    }

    if (widget.animationController != null) {
      widget.animationController.value =
          (1 + (currentVal - initVal) / (initVal)).clamp(0.0, 1.0);
    }

    _checkNeedCloseBottomSheet();

    return false;
  }

  bool _endScroll(ScrollEndNotification notification) {
    if (widget.anchors?.isNotEmpty ?? false) {
      _scrollToNearestAnchor(notification.dragDetails);
    }

    _checkNeedCloseBottomSheet();

    return false;
  }

  void _checkNeedCloseBottomSheet() {
    if (_controller.extent.currentExtent <= widget.minHeight && !_isClosing) {
      _isClosing = true;
      _dismiss();
    }
  }

  void _scrollToNearestAnchor(DragEndDetails oldDragDetails) {
    List<double> screenAnchors = _screenAnchors;

    double nextAnchor = _calculateNextAnchor(screenAnchors);

    _animateToNextAnchor(nextAnchor);
    _currentAnchor = nextAnchor;
  }

  double _calculateNextAnchor(List<double> screenAnchor) {
    if (screenAnchor.contains(_controller.extent.currentExtent)) {
      return _controller.extent.currentExtent;
    }

    List<double> nearestAnchor =
        _findNearestAnchors(screenAnchor, _controller.extent.currentExtent);
    double firstAnchor = nearestAnchor[0];
    double secondAnchor = nearestAnchor[1];

    if (firstAnchor == _currentAnchor) {
      return _findNextAnchorFromPrevious(firstAnchor, secondAnchor);
    } else if (secondAnchor == _currentAnchor) {
      return _findNextAnchorFromPrevious(secondAnchor, firstAnchor);
    } else {
      return (firstAnchor - _controller.extent.currentExtent).abs() >
              (secondAnchor - _controller.extent.currentExtent).abs()
          ? secondAnchor
          : firstAnchor;
    }
  }

  List<double> _findNearestAnchors(List<double> list, double x) {
    list.sort();
    Map<double, double> diff = Map.fromIterable(
      list,
      key: (d) => d,
      value: (d) => d - x,
    );
    double firstAnchor = diff.entries.where((me) => me.value > 0).first.key;
    double secondAnchor = diff.entries.where((me) => me.value < 0).last.key;

    return [firstAnchor, secondAnchor];
  }

  double _findNextAnchorFromPrevious(double previousAnchor, double nextAnchor) {
    double percent = 0.2;

    return (_controller.extent.currentExtent - previousAnchor).abs() >
            (nextAnchor - previousAnchor).abs() * percent
        ? nextAnchor
        : previousAnchor;
  }

  void _animateToNextAnchor(double nextAnchor) async {
    if (_controller.extent.currentExtent == nextAnchor) return;

    _topOffsetTween.begin = _controller.extent.currentExtent;
    _topOffsetTween.end = nextAnchor;

    _animationController.forward();

    if (widget.minHeight != null &&
        nextAnchor <= widget.minHeight &&
        !_isClosing) {
      _dismiss();
    }
  }

  List<double> get _screenAnchors => [
        ...widget.anchors,
        if (widget.maxHeight != null) widget.maxHeight,
        if (widget.minHeight != null) widget.minHeight,
        if (widget.initHeight != null) widget.initHeight,
      ].toSet().toList();

  void _dismiss() {
    if (widget.onDismiss != null) widget.onDismiss();
    Navigator.pop(context);
  }
}

class FlexibleBottomSheetHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  final double minHeight;

  final double maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;

  FlexibleBottomSheetHeaderDelegate({
    this.minHeight = 0,
    @required this.maxHeight,
    @required this.child,
  }) : assert(child != null);

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return child;
  }
}
