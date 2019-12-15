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
/// [minHeight], [maxHeight], [minPartHeight], [maxPartHeight] are limits of
/// bounds this widget. You can use all of them, but not both same limit
/// at once time. For example:
/// - you can set minHeight to 200 and minPartHeight to 1;
/// - you can't set minHeight to 200 and minPartHeight to 0.5;
///
/// [isCollapsible] make possible collapse widget and remove from the screen,
/// but you must be carefully to use it, set it to true only if you show this
/// widget with like showFlexibleBottomSheet() case, because it will be removed
/// by Navigator.pop(). If you set [isCollapsible] true, [minPartHeight]
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
  final double minPartHeight;
  final double initHeight;
  final double maxHeight;
  final double maxPartHeight;
  final FlexibleDraggableScrollableWidgetBuilder builder;
  final bool isCollapsible;
  final bool isExpand;
  final AnimationController animationController;
  final List<double> anchors;

  const FlexibleBottomSheet({
    Key key,
    this.minHeight,
    this.maxHeight,
    this.initHeight = 0.5,
    this.minPartHeight,
    this.maxPartHeight,
    this.builder,
    this.isCollapsible = false,
    this.isExpand = true,
    this.animationController,
    this.anchors,
  })  : assert(minHeight != null && minPartHeight == null ||
            minPartHeight != null && minHeight == null),
        assert(maxHeight != null && maxPartHeight == null ||
            maxPartHeight != null && maxHeight == null ||
            maxPartHeight == null && maxHeight == null),
        assert(
            minPartHeight == null || minPartHeight >= 0 && minPartHeight <= 1),
        assert(
            maxPartHeight == null || maxPartHeight > 0 && maxPartHeight <= 1),
        assert(!(maxPartHeight != null && minPartHeight != null) ||
            maxPartHeight > minPartHeight),
        assert(
            !(maxHeight != null && minHeight != null) || maxHeight > minHeight),
        assert(!isCollapsible || minPartHeight == 0),
        assert(animationController != null),
        super(key: key);

  const FlexibleBottomSheet.collapsible({
    Key key,
    double initHeight,
    double maxHeight,
    double maxPartHeight,
    FlexibleDraggableScrollableWidgetBuilder builder,
    bool isExpand,
    AnimationController animationController,
    List<double> anchors,
  }) : this(
          maxHeight: maxHeight,
          maxPartHeight: maxPartHeight,
          builder: builder,
          minPartHeight: 0,
          initHeight: initHeight ?? 0.5,
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

  /// Relative top offset
  double _topOffset = 0;
  double _currentAnchor;

  double get _bottom => MediaQuery.of(context).viewInsets.bottom;
  FlexibleDraggableScrollableSheetScrollController _controller;

  @override
  void initState() {
    super.initState();

    _topOffset = widget.initHeight;
    _currentAnchor = _topOffset;

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    final curve = CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastOutSlowIn,
    );
    Animation topTweenAnimation = _topOffsetTween.animate(curve);
    topTweenAnimation.addListener(() {
      if (_animationController.isAnimating) {
        _controller.extent.currentExtent = topTweenAnimation.value;
        _topOffset = topTweenAnimation.value;
      }
    });
    topTweenAnimation.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        _animationController.reset();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var maxHeight = _getMaxHeightPart(context);
    var minHeight = _getMinHeightPart(context);
    return FlexibleScrollNotifyer(
      scrollStartCallback: _startScroll,
      scrollingCallback: _scrolling,
      scrollEndCallback: _endScroll,
      child: Column(
        children: <Widget>[
          Expanded(
            child: FlexibleDraggableScrollableSheet(
              maxChildSize: maxHeight,
              minChildSize: minHeight,
              initialChildSize: widget.initHeight,
              builder: (
                context,
                ScrollController controller,
              ) {
                _controller = controller
                    as FlexibleDraggableScrollableSheetScrollController;

                return widget.builder(context, _controller, _topOffset);
              },
              expand: widget.isExpand,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: _bottom),
            child: Container(),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  double _getMaxHeightPart(BuildContext context) {
    if (widget.maxPartHeight != null) return widget.maxPartHeight;

    var height = MediaQuery.of(context).size.height;
    return (widget.maxHeight ?? height) / height;
  }

  double _getMinHeightPart(BuildContext context) {
    if (widget.minPartHeight != null) return widget.minPartHeight;

    var height = MediaQuery.of(context).size.height;
    return widget.minHeight / height;
  }

  bool _startScroll(ScrollStartNotification notification) {
    return false;
  }

  bool _scrolling(FlexibleDraggableScrollableNotification notification) {
    _topOffset = notification.extent;

    if (_isClosing) return false;

    var minHeight = _getMinHeightPart(context);

    if (widget.isCollapsible && !_isClosing) {
      if (notification.extent == minHeight) {
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
    List<double> screenAnchor = [
      ...widget.anchors,
      if (widget.maxPartHeight != null) widget.maxPartHeight,
      if (widget.minPartHeight != null) widget.minPartHeight,
      if (widget.initHeight != null) widget.initHeight,
    ].toSet().toList();

    if (screenAnchor.contains(_topOffset)) return;

    double nextAnchor = _calculateNextAnchor(screenAnchor);
    _animateToNextAnchor(nextAnchor);
    _currentAnchor = nextAnchor;
  }

  double _calculateNextAnchor(List<double> screenAnchor) {
    List<double> nearestAnchor = _findNearestAnchors(screenAnchor, _topOffset);
    double firstAnchor = nearestAnchor[0];
    double secondAnchor = nearestAnchor[1];

    if (firstAnchor == _currentAnchor) {
      return _findNextAnchorFromPrevious(firstAnchor, secondAnchor);
    } else if (secondAnchor == _currentAnchor) {
      return _findNextAnchorFromPrevious(secondAnchor, firstAnchor);
    } else {
      return (firstAnchor - _topOffset).abs() >
              (secondAnchor - _topOffset).abs()
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

    return (_topOffset - previousAnchor).abs() >
            (nextAnchor - previousAnchor).abs() * percent
        ? nextAnchor
        : previousAnchor;
  }

  void _animateToNextAnchor(double nextAnchor) {
    _topOffsetTween.begin = _topOffset;
    _topOffsetTween.end = nextAnchor;

    _animationController.forward();
  }
}
