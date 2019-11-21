import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Flexible and scrollable bottom sheet.
///
/// This bottom sheet resizing between min and max size, and when size become
/// max start scrolling content. Reduction size available when content
/// scrolled to 0 offset.
class FlexibleBottomSheet extends StatefulWidget {
  final double minHeight;
  final double minPartHeight;
  final double maxHeight;
  final double maxPartHeight;
  final List<Widget> children;
  final ScrollPhysics scrollPhysics;
  final Color backgroundColor;
  final double borderRadius;
  final bool isCollapsible;

  const FlexibleBottomSheet({
    Key key,
    this.minHeight,
    this.maxHeight,
    this.minPartHeight,
    this.maxPartHeight,
    List<Widget> children,
    this.scrollPhysics,
    Color backgroundColor,
    double borderRadius,
    bool isCollapsible = false,
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
        this.children = children ?? const [],
        this.backgroundColor = backgroundColor ?? const Color(0xFFFFFFFF),
        this.borderRadius = borderRadius ?? 16,
        this.isCollapsible = isCollapsible,
        super(key: key);

  const FlexibleBottomSheet.collapsible({
    Key key,
    double maxHeight,
    double maxPartHeight,
    List<Widget> children,
    ScrollPhysics scrollPhysics,
    Color backgroundColor,
    double borderRadius,
  }) : this(
          maxHeight: maxHeight,
          maxPartHeight: maxPartHeight,
          children: children,
          scrollPhysics: scrollPhysics,
          backgroundColor: backgroundColor,
          borderRadius: borderRadius,
          minPartHeight: 0,
          isCollapsible: true,
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
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(widget.borderRadius),
                topRight: Radius.circular(widget.borderRadius),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: widget.borderRadius),
              child: ListView(
                padding: const EdgeInsets.all(0),
                controller: scrollController,
                physics: widget.scrollPhysics,
                children: widget.children,
              ),
            ),
          );
        },
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
