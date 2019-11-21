import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Flexible and scrollable bottom sheet.
///
/// This bottom sheet resizing between min and max size, and when size become
/// max start scrolling content. Reduction size available when content
/// scrolled to 0 offset.
class FlexibleBottomSheet extends StatelessWidget {
  final double minHeight;
  final double minPartHeight;
  final double maxHeight;
  final double maxPartHeight;
  final List<Widget> children;
  final ScrollPhysics scrollPhysics;
  final Color backgroundColor;
  final double borderRadius;

  const FlexibleBottomSheet({
    Key key,
    this.minHeight,
    this.maxHeight,
    this.minPartHeight,
    this.maxPartHeight,
    List<Widget> children,
    this.scrollPhysics,
    Color backgroundColor,
    this.borderRadius = 16,
  })  : assert(minHeight != null && minPartHeight == null ||
            minPartHeight != null && minHeight == null),
        assert(maxHeight != null && maxPartHeight == null ||
            maxPartHeight != null && maxHeight == null ||
            maxPartHeight == null && maxHeight == null),
        assert(
            minPartHeight == null || minPartHeight > 0 && minPartHeight <= 1),
        assert(
            maxPartHeight == null || maxPartHeight > 0 && maxPartHeight <= 1),
        assert(!(maxPartHeight != null && minPartHeight != null) ||
            maxPartHeight > minPartHeight),
        assert(
            !(maxHeight != null && minHeight != null) || maxHeight > minHeight),
        this.children = children ?? const [],
        this.backgroundColor = backgroundColor ?? const Color(0xFFFFFFFF),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var minHeight = _getMinHeightPart(context);

    return DraggableScrollableSheet(
      maxChildSize: _getMaxHeightPart(context),
      minChildSize: minHeight,
      initialChildSize: minHeight,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(borderRadius),
              topRight: Radius.circular(borderRadius),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: borderRadius),
            child: ListView(
              padding: const EdgeInsets.all(0),
              controller: scrollController,
              physics: scrollPhysics,
              children: children,
            ),
          ),
        );
      },
    );
  }

  double _getMaxHeightPart(BuildContext context) {
    if (maxPartHeight != null) return maxPartHeight;

    var height = MediaQuery.of(context).size.height;
    return maxHeight / height;
  }

  double _getMinHeightPart(BuildContext context) {
    if (minPartHeight != null) return minPartHeight;

    var height = MediaQuery.of(context).size.height;
    return minHeight / height;
  }
}
