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

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:swipe_refresh/src/swipe_refresh_base.dart';
import 'package:swipe_refresh/src/swipe_refresh_state.dart';

// ignore_for_file: avoid-returning-widgets

/// Refresh indicator widget with Material Design style.
class MaterialSwipeRefresh extends SwipeRefreshBase {
  const MaterialSwipeRefresh({
    required Stream<SwipeRefreshState> stateStream,
    required VoidCallback onRefresh,
    Key? key,
    this.indicatorColor,
    List<Widget>? children,
    SliverChildDelegate? childrenDelegate,
    SwipeRefreshState? initState,
    Color? backgroundColor,
    ScrollController? scrollController,
    EdgeInsets? padding,
    bool shrinkWrap = false,
    ScrollViewKeyboardDismissBehavior? keyboardDismissBehavior,
    ScrollPhysics? physics,
    this.cacheExtent,
  })  : backgroundColor = backgroundColor ?? const Color(0xFFFFFFFF),
        super(
          key: key,
          children: children,
          childrenDelegate: childrenDelegate,
          stateStream: stateStream,
          initState: initState,
          onRefresh: onRefresh,
          scrollController: scrollController,
          padding: padding,
          shrinkWrap: shrinkWrap,
          keyboardDismissBehavior: keyboardDismissBehavior,
          physics: physics,
        );

  final Color? indicatorColor;
  final Color backgroundColor;
  final double? cacheExtent;

  @override
  _MaterialSwipeRefreshState createState() => _MaterialSwipeRefreshState();
}

class _MaterialSwipeRefreshState
    extends SwipeRefreshBaseState<MaterialSwipeRefresh> {
  @override
  Widget buildRefresher(
    Key key,
    List<Widget> children,
    Future<void> Function() onRefresh,
  ) {
    return RefreshIndicator(
      key: key,
      onRefresh: onRefresh,
      color: widget.indicatorColor,
      backgroundColor: widget.backgroundColor,
      child: widget.childrenDelegate == null
          ? ListView(
              shrinkWrap: widget.shrinkWrap,
              padding: widget.padding,
              cacheExtent: widget.cacheExtent,
              controller: widget.scrollController ?? ScrollController(),
              physics: AlwaysScrollableScrollPhysics(parent: widget.physics),
              keyboardDismissBehavior: widget.keyboardDismissBehavior ??
                  ScrollViewKeyboardDismissBehavior.manual,
              children: children,
            )
          : ListView.custom(
              shrinkWrap: widget.shrinkWrap,
              cacheExtent: widget.cacheExtent,
              padding: widget.padding,
              childrenDelegate: widget.childrenDelegate!,
              controller: widget.scrollController ?? ScrollController(),
              keyboardDismissBehavior: widget.keyboardDismissBehavior ??
                  ScrollViewKeyboardDismissBehavior.manual,
              physics: AlwaysScrollableScrollPhysics(parent: widget.physics),
            ),
    );
  }

  @override
  void onUpdateState(SwipeRefreshState state) {
    if (state == SwipeRefreshState.loading) {
      (refreshKey.currentState as RefreshIndicatorState).show();
    }

    if (state == SwipeRefreshState.hidden) {
      if (completer != null) {
        completer!.complete();
        completer = null;
      }
    }
  }
}
