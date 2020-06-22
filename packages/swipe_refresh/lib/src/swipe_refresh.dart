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
  final ScrollController scrollController;
  final SliverChildDelegate childrenDelegate;
  final EdgeInsets padding;

  const SwipeRefresh(
    this.style, {
    this.key,
    this.children,
    this.stateStream,
    this.initState,
    this.onRefresh,
    this.scrollController,
    this.childrenDelegate,
    this.padding,
    this.indicatorColor,
    Color backgroundColor,
    double refreshTriggerPullDistance,
    double refreshIndicatorExtent,
    RefreshControlIndicatorBuilder indicatorBuilder,
  })  : this.backgroundColor = backgroundColor ?? const Color(0xFFFFFFFF),
        this.refreshTriggerPullDistance = refreshTriggerPullDistance ??
            CupertinoSwipeRefresh.DEFAULT_REFRESH_TRIGGER_PULL_DISTANCE,
        this.refreshIndicatorExtent = refreshIndicatorExtent ??
            CupertinoSwipeRefresh.DEFAULT_REFRESH_INDICATOR_EXTENT,
        this.indicatorBuilder = indicatorBuilder ??
            CupertinoSliverRefreshControl.buildSimpleRefreshIndicator;

  /// Create refresh indicator adaptive to platform.
  const SwipeRefresh.adaptive(
      {Key key,
      List<Widget> children,
      Stream<SwipeRefreshState> stateStream,
      SwipeRefreshState initState,
      VoidCallback onRefresh,
      Color indicatorColor,
      Color backgroundColor,
      double refreshTriggerPullDistance,
      double refreshIndicatorExtent,
      RefreshControlIndicatorBuilder indicatorBuilder,
      ScrollController scrollController,
      EdgeInsets padding})
      : this(
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
          scrollController: scrollController,
          padding: padding,
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
    ScrollController scrollController,
    EdgeInsets padding,
  }) : this(
          SwipeRefreshStyle.material,
          key: key,
          children: children,
          stateStream: stateStream,
          initState: initState,
          onRefresh: onRefresh,
          indicatorColor: indicatorColor,
          backgroundColor: backgroundColor,
          scrollController: scrollController,
          padding: padding,
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
    ScrollController scrollController,
    EdgeInsets padding,
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
          scrollController: scrollController,
          padding: padding,
        );

  /// Crete SwipeRefresh as common link
  /// remove some conflicts between ScrollControllers when ListView added into
  /// SwipeRefresh (remove need to add extra ListView)
  factory SwipeRefresh.builder({
    Key key,
    @required IndexedWidgetBuilder itemBuilder,
    @required int itemCount,
    Stream<SwipeRefreshState> stateStream,
    SwipeRefreshState initState,
    VoidCallback onRefresh,
    Color indicatorColor,
    Color backgroundColor,
    double refreshTriggerPullDistance,
    double refreshIndicatorExtent,
    RefreshControlIndicatorBuilder indicatorBuilder,
    ScrollController scrollController,
    EdgeInsets padding,
  }) {
    assert(itemBuilder != null);
    assert(itemCount != null);

    return SwipeRefresh(
      SwipeRefreshStyle.adaptive,
      key: key,
      stateStream: stateStream,
      initState: initState,
      onRefresh: onRefresh,
      indicatorColor: indicatorColor,
      backgroundColor: backgroundColor,
      refreshTriggerPullDistance: refreshTriggerPullDistance,
      refreshIndicatorExtent: refreshIndicatorExtent,
      indicatorBuilder: indicatorBuilder,
      scrollController: scrollController,
      padding: padding,
      childrenDelegate: SliverChildBuilderDelegate(
        itemBuilder,
        childCount: itemCount,
        addAutomaticKeepAlives: true,
        addRepaintBoundaries: true,
        addSemanticIndexes: true,
      ),
    );
  }

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
          childrenDelegate: childrenDelegate,
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
          childrenDelegate: childrenDelegate,
          stateStream: stateStream,
          initState: initState,
          onRefresh: onRefresh,
          refreshIndicatorExtent: refreshIndicatorExtent,
          refreshTriggerPullDistance: refreshTriggerPullDistance,
          indicatorBuilder: indicatorBuilder,
        );
      case SwipeRefreshStyle.builder:
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

  /// Builder
  builder,
}
