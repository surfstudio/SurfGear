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
class FlexibleBottomSheet extends StatefulWidget {
  final double minHeight;
  final double minPartHeight;
  final double maxHeight;
  final double maxPartHeight;
  final ScrollableWidgetBuilder builder;
  final bool isCollapsible;
  final bool isExpand;

  const FlexibleBottomSheet({
    Key key,
    this.minHeight,
    this.maxHeight,
    this.minPartHeight,
    this.maxPartHeight,
    this.builder,
    bool isCollapsible = false,
    this.isExpand = true,
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
        this.isCollapsible = isCollapsible,
        super(key: key);

  const FlexibleBottomSheet.collapsible({
    Key key,
    double maxHeight,
    double maxPartHeight,
    ScrollableWidgetBuilder builder,
    bool isExpand,
  }) : this(
          maxHeight: maxHeight,
          maxPartHeight: maxPartHeight,
          builder: builder,
          minPartHeight: 0,
          isCollapsible: true,
          isExpand: isExpand,
        );

  @override
  _FlexibleBottomSheetState createState() => _FlexibleBottomSheetState();
}

class _FlexibleBottomSheetState extends State<FlexibleBottomSheet> {
  bool _isClosing = false;

  @override
  Widget build(BuildContext context) {
    var maxHeight = _getMaxHeightPart(context);
    var minHeight = _getMinHeightPart(context);

    return NotificationListener<DraggableScrollableNotification>(
      onNotification: _isClosing ? null : _processNotify,
      child: DraggableScrollableSheet(
        maxChildSize: maxHeight,
        minChildSize: minHeight,
        initialChildSize: _getInitHeight(minHeight, maxHeight),
        builder: widget.builder,
        expand: widget.isExpand,
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

  double _getInitHeight(double min, double max) {
    if (min > 0) {
      return min;
    }

    return (max + min) / 2;
  }

  bool _processNotify(DraggableScrollableNotification notification) {
    var minHeight = _getMinHeightPart(context);

    if (widget.isCollapsible && !_isClosing) {
      if (notification.extent == minHeight) {
        setState(() {
          _isClosing = true;
          Navigator.of(context).pop();
        });
      }
    }

    return false;
  }
}
