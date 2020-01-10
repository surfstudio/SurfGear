import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:swipe_refresh/src/material_swipe_refresh.dart';
import 'package:swipe_refresh/src/swipe_refresh_state.dart';

import 'cupertino_swipe_refresh.dart';

/// Refresh indicator widget.
///
/// Params for Material Design style:
/// [indicatorColor], [backgroundColor].
///
/// Params for Cupertino style:
/// [refreshTriggerPullDistance], [refreshIndicatorExtent], [indicatorBuilder].
class SwipeRefresh extends StatelessWidget {
  final Key key;
  final List<Widget> children;
  final VoidCallback onRefresh;
  final SwipeRefreshState initState;
  final Stream<SwipeRefreshState> stateStream;
  final Color indicatorColor;
  final Color backgroundColor;
  final double refreshTriggerPullDistance;
  final double refreshIndicatorExtent;
  final RefreshControlIndicatorBuilder indicatorBuilder;

  final SwipeRefreshStyle style;

  const SwipeRefresh(
    this.style, {
    this.key,
    this.children,
    this.stateStream,
    this.initState,
    this.onRefresh,
    Color indicatorColor,
    Color backgroundColor,
    double refreshTriggerPullDistance,
    double refreshIndicatorExtent,
    RefreshControlIndicatorBuilder indicatorBuilder,
  })  : this.indicatorColor = indicatorColor ?? const Color(0xFFFF0000),
        this.backgroundColor = backgroundColor ?? const Color(0xFFFFFFFF),
        this.refreshTriggerPullDistance = refreshTriggerPullDistance ??
            CupertinoSwipeRefresh.DEFAULT_REFRESH_TRIGGER_PULL_DISTANCE,
        this.refreshIndicatorExtent = refreshIndicatorExtent ??
            CupertinoSwipeRefresh.DEFAULT_REFRESH_INDICATOR_EXTENT,
        this.indicatorBuilder = indicatorBuilder ??
            CupertinoSliverRefreshControl.buildSimpleRefreshIndicator;

  /// Create refresh indicator adaptive to platform.
  const SwipeRefresh.adaptive({
    Key key,
    List<Widget> children,
    Stream<SwipeRefreshState> stateStream,
    SwipeRefreshState initState,
    VoidCallback onRefresh,
    Color indicatorColor,
    Color backgroundColor,
    double refreshTriggerPullDistance,
    double refreshIndicatorExtent,
    RefreshControlIndicatorBuilder indicatorBuilder,
  }) : this(
          SwipeRefreshStyle.adaptive,
          key: key,
          children: children,
          stateStream: stateStream,
          initState: initState,
          onRefresh: onRefresh,
          indicatorColor: indicatorColor,
          backgroundColor: backgroundColor,
          refreshTriggerPullDistance: refreshTriggerPullDistance,
          refreshIndicatorExtent: refreshIndicatorExtent,
          indicatorBuilder: indicatorBuilder,
        );

  /// Create refresh indicator with Material Design style.
  const SwipeRefresh.material({
    Key key,
    List<Widget> children,
    Stream<SwipeRefreshState> stateStream,
    SwipeRefreshState initState,
    VoidCallback onRefresh,
    Color indicatorColor,
    Color backgroundColor,
  }) : this(
          SwipeRefreshStyle.material,
          key: key,
          children: children,
          stateStream: stateStream,
          initState: initState,
          onRefresh: onRefresh,
          indicatorColor: indicatorColor,
          backgroundColor: backgroundColor,
        );

  /// Create refresh indicator with Cupertino style.
  const SwipeRefresh.cupertino({
    Key key,
    List<Widget> children,
    Stream<SwipeRefreshState> stateStream,
    SwipeRefreshState initState,
    VoidCallback onRefresh,
    double refreshTriggerPullDistance,
    double refreshIndicatorExtent,
    RefreshControlIndicatorBuilder indicatorBuilder,
  }) : this(
          SwipeRefreshStyle.cupertino,
          key: key,
          children: children,
          stateStream: stateStream,
          initState: initState,
          onRefresh: onRefresh,
          refreshTriggerPullDistance: refreshTriggerPullDistance,
          refreshIndicatorExtent: refreshIndicatorExtent,
          indicatorBuilder: indicatorBuilder,
        );

  @override
  Widget build(BuildContext context) {
    return _buildByStyle(style);
  }

  Widget _buildByStyle(SwipeRefreshStyle style) {
    switch (style) {
      case SwipeRefreshStyle.material:
        return MaterialSwipeRefresh(
          key: key,
          children: children,
          stateStream: stateStream,
          initState: initState,
          onRefresh: onRefresh,
          backgroundColor: backgroundColor,
          indicatorColor: indicatorColor,
        );
      case SwipeRefreshStyle.cupertino:
        return CupertinoSwipeRefresh(
          key: key,
          children: children,
          stateStream: stateStream,
          initState: initState,
          onRefresh: onRefresh,
          refreshIndicatorExtent: refreshIndicatorExtent,
          refreshTriggerPullDistance: refreshTriggerPullDistance,
          indicatorBuilder: indicatorBuilder,
        );
      case SwipeRefreshStyle.adaptive:
        if (Platform.isAndroid) {
          return _buildByStyle(SwipeRefreshStyle.material);
        } else if (Platform.isIOS) {
          return _buildByStyle(SwipeRefreshStyle.cupertino);
        }
    }

    return Container();
  }
}

/// Indicator style.
enum SwipeRefreshStyle {
  /// Material Design
  material,

  /// Cupertino
  cupertino,

  /// Adaptive
  adaptive,
}
