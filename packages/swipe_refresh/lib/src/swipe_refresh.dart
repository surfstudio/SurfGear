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
  const SwipeRefresh(
    this.style, {
    Key key,
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
  })  : backgroundColor = backgroundColor ?? const Color(0xFFFFFFFF),
        refreshTriggerPullDistance = refreshTriggerPullDistance ??
            CupertinoSwipeRefresh.defaultRefreshTriggerPullDistance,
        refreshIndicatorExtent = refreshIndicatorExtent ??
            CupertinoSwipeRefresh.defaultRefreshIndicatorExtent,
        indicatorBuilder = indicatorBuilder ??
            CupertinoSliverRefreshControl.buildRefreshIndicator,
        super(key: key);

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
    @required IndexedWidgetBuilder itemBuilder,
    @required int itemCount,
    Key key,
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

  @override
  Widget build(BuildContext context) {
    return _buildByStyle(style);
  }

  Widget _buildByStyle(SwipeRefreshStyle style) {
    switch (style) {
      case SwipeRefreshStyle.material:
        return MaterialSwipeRefresh(
          key: key,
          childrenDelegate: childrenDelegate,
          stateStream: stateStream,
          initState: initState,
          onRefresh: onRefresh,
          backgroundColor: backgroundColor,
          indicatorColor: indicatorColor,
          children: children,
        );
      case SwipeRefreshStyle.cupertino:
        return CupertinoSwipeRefresh(
          key: key,
          childrenDelegate: childrenDelegate,
          stateStream: stateStream,
          initState: initState,
          onRefresh: onRefresh,
          refreshIndicatorExtent: refreshIndicatorExtent,
          refreshTriggerPullDistance: refreshTriggerPullDistance,
          indicatorBuilder: indicatorBuilder,
          children: children,
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
