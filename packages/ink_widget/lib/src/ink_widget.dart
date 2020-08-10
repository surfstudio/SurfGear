// Copyright (c) 2019-present,  SurfStudio LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';

/// Wrapper for InkWell
/// Solves the problem when Material effects overlap with a child’s decoration
class InkWidget extends StatelessWidget {
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
          customBorder: customBorder ?? shapeBorder,
          onTap: onTap,
          onDoubleTap: onDoubleTap,
          onLongPress: onLongPress,
          onTapDown: onTapDown,
          onTapCancel: onTapCancel,
          onHighlightChanged: onHighlightChanged,
          onHover: onHover,
          focusColor: focusColor,
          hoverColor: hoverColor,
          highlightColor: highlightColor,
          splashColor: splashColor,
          splashFactory: splashFactory,
          radius: radius,
          borderRadius: borderRadius,
          enableFeedback: enableFeedback,
          excludeFromSemantics: excludeFromSemantics,
          focusNode: focusNode,
          canRequestFocus: canRequestFocus,
          onFocusChange: onFocusChange,
          autofocus: autofocus,
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
