import 'dart:math';

import 'package:bottom_sheet/src/flexible_draggable_scrollable_sheet.dart';
import 'package:bottom_sheet/src/widgets/flexible_bottom_sheet_scroll_notifyer.dart';
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

class _FlexibleBottomSheetState extends State<FlexibleBottomSheet> {
  bool _isClosing = false;

  /// Relative top offset
  double _topOffset = 0;

  double get _bottom => MediaQuery.of(context).viewInsets.bottom;
  FlexibleDraggableScrollableSheetScrollController _controller;

  @override
  void initState() {
    super.initState();
    _topOffset = widget.initHeight;
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
              builder: (context,
                  FlexibleDraggableScrollableSheetScrollController controller) {
                _controller = controller;
                return widget.builder(context, controller);
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
    print("ScrollStartNotification");
    print("globalPosition = ${notification.dragDetails.globalPosition}");
    print("localPosition = ${notification.dragDetails.localPosition}");
    return false;
  }

  bool _scrolling(FlexibleDraggableScrollableNotification notification) {
    _topOffset = notification.extent;
    print("FlexibleDraggableScrollableNotification");
    print("extent = ${notification.extent}");

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
    print("ScrollEndNotification");
    // print("primaryVelocity = ${notification.dragDetails.primaryVelocity}");
    // print("velocity = ${notification.dragDetails.velocity}");

    if (widget.anchors?.isNotEmpty ?? false) {
      _scrollToNearestArchor(notification.dragDetails);
    }

    return false;
  }

  void _scrollToNearestArchor(DragEndDetails oldDragDetails) {
    if (widget.anchors.contains(_topOffset)) return;
    // TODO добавить проверку на максимальную раскрытость

    List<double> screenAnchor = [
      if (widget.maxPartHeight != null) widget.maxPartHeight,
      ...widget.anchors,
      if (widget.minPartHeight != null) widget.minPartHeight,
    ];
    List<double> diff = screenAnchor
        .map(
          (d) => (d - _topOffset).abs(),
        )
        .toList();
    int minIndex = diff.indexOf(diff.reduce(min));
    double currentHeight = screenAnchor[minIndex];
    _controller.extent.currentExtent = currentHeight;
    print("currentHeight = $currentHeight");
  }
}
