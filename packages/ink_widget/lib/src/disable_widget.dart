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

/// Disable widget for usage in InkWidget
class DisableWidget extends StatelessWidget {
  const DisableWidget({
    required this.color,
    required this.opacity,
    Key? key,
    this.decoration,
    this.defaultDecorationShape,
  }) : super(key: key);

  final Color color;
  final double opacity;

  final Decoration? decoration;
  final ShapeBorder? defaultDecorationShape;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Opacity(
        opacity: opacity,
        child: Container(
          color: (decoration == null && defaultDecorationShape == null)
              ? color
              : null,
          decoration: decoration ?? _defaultDecoration(),
        ),
      ),
    );
  }

  Decoration? _defaultDecoration() {
    return defaultDecorationShape != null
        ? ShapeDecoration(color: color, shape: defaultDecorationShape!)
        : null;
  }
}
