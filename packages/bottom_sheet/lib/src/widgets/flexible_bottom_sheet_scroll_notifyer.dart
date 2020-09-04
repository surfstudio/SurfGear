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

import 'package:bottom_sheet/src/widgets/flexible_draggable_scrollable_sheet.dart';
import 'package:flutter/material.dart';

/// Start scrolling
typedef ScrollStartCallback = bool Function(ScrollStartNotification);

/// Scrolling
typedef ScrollCallback = bool Function(FlexibleDraggableScrollableNotification);

/// Scroll finished
typedef ScrollEndCallback = bool Function(ScrollEndNotification);

/// Listen drag-notifications
class FlexibleScrollNotifyer extends StatelessWidget {
  const FlexibleScrollNotifyer({
    Key key,
    this.child,
    this.scrollStartCallback,
    this.scrollingCallback,
    this.scrollEndCallback,
  }) : super(key: key);

  final Widget child;

  final ScrollStartCallback scrollStartCallback;
  final ScrollCallback scrollingCallback;
  final ScrollEndCallback scrollEndCallback;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollStartNotification>(
      onNotification: scrollStartCallback,
      child: NotificationListener<ScrollEndNotification>(
        onNotification: scrollEndCallback,
        child: NotificationListener<FlexibleDraggableScrollableNotification>(
          onNotification: scrollingCallback,
          child: child,
        ),
      ),
    );
  }
}
