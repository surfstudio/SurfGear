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
import 'package:ink_widget/ink_widget.dart';
import 'package:virtual_keyboard/src/virtual_keyboard_effect.dart';

class TableButton extends StatelessWidget {
  const TableButton({
    required this.child,
    Key? key,
    this.width,
    this.height,
    this.onTap,
    this.padding,
    this.keyDecoration,
    this.inkShapeRipple,
    this.inkShapeBorder,
    VirtualKeyboardEffect? virtualKeyboardEffect,
    bool? useAsKey,
  })  : virtualKeyboardEffect =
            virtualKeyboardEffect ?? VirtualKeyboardEffect.none,
        useAsKey = useAsKey ?? false,
        super(key: key);

  /// Button Width
  final double? width;

  /// Button Height
  final double? height;

  final Widget child;

  final VoidCallback? onTap;

  final EdgeInsets? padding;

  final VirtualKeyboardEffect virtualKeyboardEffect;

  /// Use child instead as a key
  final bool useAsKey;

  /// Key decoration
  final BoxDecoration? keyDecoration;

  /// [ShapeDecoration] for InkWell Effect
  final ShapeDecoration? inkShapeRipple;

  /// [ShapeBorder] for InkWell
  final ShapeBorder? inkShapeBorder;

  @override
  Widget build(BuildContext context) {
    if (useAsKey) {
      return child;
    }

    return _buildContainer(
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: height ?? 0.0,
          ),
          child: SizedBox(
            width: width,
            child: Center(child: child),
          ),
        ),
      ),
    );
  }

  // ignore: avoid-returning-widgets
  Widget _buildContainer({required Widget child}) {
    switch (virtualKeyboardEffect) {
      case VirtualKeyboardEffect.keyboardRipple:
        return TableRowInkWell(
          onTap: onTap,
          child: Container(
            decoration: keyDecoration,
            child: child,
          ),
        );
      case VirtualKeyboardEffect.keyRipple:
        return InkWidget(
          shape: inkShapeRipple,
          shapeBorder: inkShapeBorder,
          onTap: onTap,
          child: Container(
            decoration: keyDecoration,
            child: Center(
              child: child,
            ),
          ),
        );
      case VirtualKeyboardEffect.none:
      default:
        return GestureDetector(
          onTap: onTap,
          behavior: HitTestBehavior.opaque,
          child: Container(
            decoration: keyDecoration,
            child: child,
          ),
        );
    }
  }
}
