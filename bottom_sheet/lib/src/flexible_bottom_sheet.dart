import 'dart:math';

import 'package:bottom_sheet/src/widgets/flexible_bottom_sheet_scroll_notifyer.dart';
import 'package:bottom_sheet/src/widgets/flexible_draggable_scrollable_sheet.dart';
import 'package:flutter/cupertino.dart';
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
  final bool isCollapsible;
  final bool isExpand;
  final AnimationController animationController;
  final List<double> anchors;

  const FlexibleBottomSheet({
    Key key,
    this.minHeight,
    this.initHeight,
    this.maxHeight,
    this.builder,
    this.isCollapsible = false,
    this.isExpand = true,
    this.animationController,
    this.anchors,
  })  : assert(minHeight == null || minHeight >= 0 && minHeight <= 1),
        assert(maxHeight == null || maxHeight > 0 && maxHeight <= 1),
        assert(
            !(maxHeight != null && minHeight != null) || maxHeight > minHeight),
        assert(!isCollapsible || minHeight == 0),
        assert(animationController != null),
        super(key: key);

  const FlexibleBottomSheet.collapsible({
    Key key,
    double initHeight,
    double maxHeight,
    FlexibleDraggableScrollableWidgetBuilder builder,
    bool isExpand,
    AnimationController animationController,
    List<double> anchors,
  }) : this(
          maxHeight: maxHeight,
          builder: builder,
          minHeight: 0,
          initHeight: initHeight,
          isCollapsible: true,
          isExpand: isExpand,
          animationController: animationController,
          anchors: anchors,
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
            child: widget.builder(
              context,
              _controller,
              _controller.extent.currentExtent,
            ),
          );
        },
        expand: widget.isExpand,
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
          Navigator.of(context).pop();
        });
      }
    }

    var currentVal = notification.extent;
    var initVal = notification.initialExtent;

    if (initVal == 0) {
      initVal = currentVal;
    }

    widget.animationController.value =
        (1 + (currentVal - initVal) / (initVal)).clamp(0.0, 1.0);

    return false;
  }

  bool _endScroll(ScrollEndNotification notification) {
    if (widget.anchors?.isNotEmpty ?? false) {
      _scrollToNearestAnchor(notification.dragDetails);
    }

    return false;
  }

  void _scrollToNearestAnchor(DragEndDetails oldDragDetails) {
    List<double> screenAnchors = _screenAnchors;
    if (screenAnchors.contains(_controller.extent.currentExtent)) return;

    double nextAnchor = _calculateNextAnchor(screenAnchors);

    _animateToNextAnchor(nextAnchor);
    _currentAnchor = nextAnchor;
  }

  double _calculateNextAnchor(List<double> screenAnchor) {
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

    if (widget.minHeight != null && nextAnchor <= widget.minHeight) {
      Navigator.of(context).pop();
    }
  }

  List<double> get _screenAnchors => [
        ...widget.anchors,
        if (widget.maxHeight != null) widget.maxHeight,
        if (widget.minHeight != null) widget.minHeight,
        if (widget.initHeight != null) widget.initHeight,
      ].toSet().toList();
}
