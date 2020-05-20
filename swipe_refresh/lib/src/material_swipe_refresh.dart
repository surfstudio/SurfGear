import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:swipe_refresh/src/swipe_refresh_base.dart';
import 'package:swipe_refresh/src/swipe_refresh_state.dart';

/// Refresh indicator widget with Material Design style.
class MaterialSwipeRefresh extends SwipeRefreshBase {
  final Color indicatorColor;
  final Color backgroundColor;

  // final ScrollController scrollController;

  const MaterialSwipeRefresh({
    Key key,
    List<Widget> children,
    SliverChildDelegate childrenDelegate,
    Stream<SwipeRefreshState> stateStream,
    SwipeRefreshState initState,
    VoidCallback onRefresh,
    this.indicatorColor,
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
          scrollController: scrollController,
          onRefresh: onRefresh,
          padding: padding,
        );

  @override
  _MaterialSwipeRefreshState createState() => _MaterialSwipeRefreshState();
}

class _MaterialSwipeRefreshState
    extends SwipeRefreshBaseState<MaterialSwipeRefresh> {
  @override
  Widget buildRefresher(Key key, List<Widget> children, onRefresh) {
    return RefreshIndicator(
      key: key,
      child: widget.childrenDelegate == null
          ? ListView(
              padding: widget.padding,
              controller: widget.scrollController ?? ScrollController(),
              children: children,
              physics: AlwaysScrollableScrollPhysics(),
            )
          : ListView.custom(
              padding: widget.padding,
              childrenDelegate: widget.childrenDelegate,
              controller: widget.scrollController ?? ScrollController(),
              physics: AlwaysScrollableScrollPhysics(),
            ),
      onRefresh: onRefresh,
      color: widget.indicatorColor,
      backgroundColor: widget.backgroundColor,
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
