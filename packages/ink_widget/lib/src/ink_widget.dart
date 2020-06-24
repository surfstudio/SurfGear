import 'package:flutter/material.dart';

/// Wrapper for InkWell
/// Solves the problem when Material effects overlap with a child’s decoration
class InkWidget extends StatelessWidget {
  final Widget child;

  /// true - disable the widget
  /// false enable the widget
  final bool disable;

  /// opacity for disabled state
  final double disableOpacity;

  /// color for disabled state
  final Color disableColor;

  /// shape for InkWell and disable widget
  final ShapeDecoration shape;

  /// shape border for InkWell and disable widget
  final ShapeBorder shapeBorder;

  /// custom disable widget
  final Widget disableWidget;

  /// custom InlWell Widget
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
    this.shapeBorder,
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
        disableColor = disableColor ?? Colors.black.withOpacity(.5),
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
          customBorder: this.customBorder ?? shapeBorder,
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

  ShapeDecoration get _shapeDisable {
    if (shape == null && shapeBorder == null) return null;
    return shape ??
        ShapeDecoration(
          color: disableColor,
          shape: shapeBorder,
        );
  }

  Color get _disableColor => shape == null ? disableColor : null;

  Widget _buildDisableWidget() {
    return disableWidget ??
        Positioned.fill(
          child: Opacity(
            opacity: disableOpacity,
            child: Container(
              color: _disableColor,
              decoration: _shapeDisable,
            ),
          ),
        );
  }
}
