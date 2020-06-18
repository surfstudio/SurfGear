import 'package:flutter/material.dart';

/// Wrapper for InkWell
class InkWidget extends StatelessWidget {
  final Widget child;
  final bool disable;
  final double disableOpacity;
  final Color disableColor;
  final ShapeBorder shape;
  final Widget disableWidget;
  final InkWell inkWellWidget;

  /// Parameters from InkWell
  final GestureTapCallback onTap;
  final GestureTapCallback onDoubleTap;
  final GestureLongPressCallback onLongPress;
  final GestureTapDownCallback onTapDown;
  final GestureTapCancelCallback onTapCancel;
  final ValueChanged<bool> onHighlightChanged;
  final ValueChanged<bool> onHover;
  final Color focusColor;
  final Color hoverColor;
  final Color highlightColor;
  final Color splashColor;
  final InteractiveInkFeatureFactory splashFactory;
  final double radius;
  final BorderRadius borderRadius;
  final ShapeBorder customBorder;
  final bool enableFeedback;
  final bool excludeFromSemantics;
  final FocusNode focusNode;
  final bool canRequestFocus;
  final ValueChanged<bool> onFocusChange;
  final bool autofocus;

  InkWidget({
    Key key,
    this.child,
    bool disable,
    double disableOpacity,
    Color disableColor,
    this.disableWidget,
    this.shape,
    this.inkWellWidget,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    this.onTapDown,
    this.onTapCancel,
    this.onHighlightChanged,
    this.onHover,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.splashColor,
    this.splashFactory,
    this.radius,
    this.borderRadius,
    this.customBorder,
    bool enableFeedback,
    bool excludeFromSemantics,
    this.focusNode,
    bool canRequestFocus,
    this.onFocusChange,
    bool autofocus,
  })  : disable = disable ?? false,
        disableOpacity = disableOpacity ?? .5,
        disableColor = disableColor ?? Colors.black,
        enableFeedback = enableFeedback ?? true,
        excludeFromSemantics = excludeFromSemantics ?? false,
        canRequestFocus = canRequestFocus ?? true,
        autofocus = autofocus ?? false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        child,
        Positioned.fill(
          child: Material(
            type: MaterialType.transparency,
            child: _buildInkWell(),
          ),
        ),
        if (disable) _buildDisableWidget(),
      ],
    );
  }

  InkWell _buildInkWell() {
    return inkWellWidget ??
        InkWell(
          customBorder: this.customBorder ?? shape,
          onTap: this.onTap,
          onDoubleTap: this.onDoubleTap,
          onLongPress: this.onLongPress,
          onTapDown: this.onTapDown,
          onTapCancel: this.onTapCancel,
          onHighlightChanged: this.onHighlightChanged,
          onHover: this.onHover,
          focusColor: this.focusColor,
          hoverColor: this.hoverColor,
          highlightColor: this.highlightColor,
          splashColor: this.splashColor,
          splashFactory: this.splashFactory,
          radius: this.radius,
          borderRadius: this.borderRadius,
          enableFeedback: this.enableFeedback,
          excludeFromSemantics: this.excludeFromSemantics,
          focusNode: this.focusNode,
          canRequestFocus: this.canRequestFocus,
          onFocusChange: this.onFocusChange,
          autofocus: this.autofocus,
        );
  }

  Widget _buildDisableWidget() {
    return disableWidget ??
        Positioned.fill(
          child: Opacity(
            opacity: disableOpacity,
            child: Container(
              decoration: ShapeDecoration(
                color: disableColor,
                shape: shape,
              ),
            ),
          ),
        );
  }
}
