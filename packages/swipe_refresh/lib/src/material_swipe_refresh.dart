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

/// Refresh indicator widget with Material Design style.
class MaterialSwipeRefresh extends SwipeRefreshBase {
  const MaterialSwipeRefresh({
    Key key,
    this.indicatorColor,
    List<Widget> children,
    SliverChildDelegate childrenDelegate,
    Stream<SwipeRefreshState> stateStream,
    SwipeRefreshState initState,
    VoidCallback onRefresh,
    Color backgroundColor,
    ScrollController scrollController,
    EdgeInsets padding,
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
        );

  final Color indicatorColor;
  final Color backgroundColor;

  @override
  _MaterialSwipeRefreshState createState() => _MaterialSwipeRefreshState();
}

class _MaterialSwipeRefreshState
    extends SwipeRefreshBaseState<MaterialSwipeRefresh> {
  @override
  Widget buildRefresher(Key key, List<Widget> children, onRefresh) {
    return RefreshIndicator(
      key: key,
      onRefresh: onRefresh,
      color: widget.indicatorColor,
      backgroundColor: widget.backgroundColor,
      child: widget.childrenDelegate == null
          ? ListView(
              padding: widget.padding,
              controller: widget.scrollController ?? ScrollController(),
              physics: const AlwaysScrollableScrollPhysics(),
              children: children,
            )
          : ListView.custom(
              padding: widget.padding,
              childrenDelegate: widget.childrenDelegate,
              controller: widget.scrollController ?? ScrollController(),
              physics: const AlwaysScrollableScrollPhysics(),
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
        completer.complete();
        completer = null;
      }
    }
  }
}
