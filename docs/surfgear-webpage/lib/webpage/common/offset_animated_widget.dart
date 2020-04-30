import 'package:flutter/cupertino.dart';

/// Widget that responds to scroll position
class ScrollOffsetWidget extends StatefulWidget {
  /// Webpage scroll offset
  final double scrollOffset;

  /// child widget
  final Widget child;

  /// Callback that fires when the scroll position> = widget position
  final VoidCallback hasScrolled;

  ScrollOffsetWidget({
    @required this.scrollOffset,
    @required this.child,
    @required this.hasScrolled,
  });

  @override
  State<StatefulWidget> createState() {
    return ScrollOffsetWidgetState();
  }
}

class ScrollOffsetWidgetState extends State<ScrollOffsetWidget> {
  /// Key to find the position on the screen
  GlobalKey _globalKey = GlobalKey();

  /// A trigger that determines that the scroll has reached the widget
  bool _hasScrolled = false;

  /// Search widget offset by key
  double _getVerticalOffset() {
    final RenderBox renderBox = _globalKey.currentContext.findRenderObject();
    final Offset offset = renderBox.localToGlobal(Offset.zero);

    return offset.dy;
  }

  @override
  Widget build(BuildContext context) {
    // if the scroll position> = the vertical position of the widget
    // start the animation
    Future.delayed(Duration(milliseconds: 1), () {
      if (widget.scrollOffset >= _getVerticalOffset()) {
        if (!_hasScrolled) {
          widget.hasScrolled();
        }
        _hasScrolled = true;
      }
    });
    return Container(
      key: _globalKey,
      child: widget.child,
    );
  }
}
