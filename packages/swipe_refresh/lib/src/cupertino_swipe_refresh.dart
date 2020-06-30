import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:swipe_refresh/src/swipe_refresh_base.dart';
import 'package:swipe_refresh/src/swipe_refresh_state.dart';

/// Refresh indicator widget with Cupertino style.
class CupertinoSwipeRefresh extends SwipeRefreshBase {
  static const double DEFAULT_REFRESH_TRIGGER_PULL_DISTANCE = 100.0;
  static const double DEFAULT_REFRESH_INDICATOR_EXTENT = 60.0;

  final double refreshTriggerPullDistance;
  final double refreshIndicatorExtent;
  final RefreshControlIndicatorBuilder indicatorBuilder;

  const CupertinoSwipeRefresh({
    Key key,
    List<Widget> children,
    SliverChildDelegate childrenDelegate,
    Stream<SwipeRefreshState> stateStream,
    SwipeRefreshState initState,
    VoidCallback onRefresh,
    EdgeInsets padding,
    ScrollController scrollController,
    this.refreshTriggerPullDistance = DEFAULT_REFRESH_TRIGGER_PULL_DISTANCE,
    this.refreshIndicatorExtent = DEFAULT_REFRESH_INDICATOR_EXTENT,
    this.indicatorBuilder =
        CupertinoSliverRefreshControl.buildSimpleRefreshIndicator,
  }) : super(
          key: key,
          children: children,
          childrenDelegate: childrenDelegate,
          stateStream: stateStream,
          initState: initState,
          onRefresh: onRefresh,
          padding: padding,
          scrollController: scrollController,
        );

  @override
  SwipeRefreshBaseState createState() =>
      _CupertinoSwipeRefreshState(scrollController);
}

class _CupertinoSwipeRefreshState
    extends SwipeRefreshBaseState<CupertinoSwipeRefresh> {
  final ScrollController _scrollController;

  _CupertinoSwipeRefreshState(ScrollController scrollController)
      : _scrollController = scrollController ?? ScrollController();

  @override
  Widget buildRefresher(Key key, List<Widget> children, onRefresh) {
    return CustomScrollView(
      controller: _scrollController,
      physics: BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      slivers: <Widget>[
        CupertinoSliverRefreshControl(
          key: key,
          onRefresh: onRefresh,
          refreshTriggerPullDistance: widget.refreshTriggerPullDistance,
          refreshIndicatorExtent: widget.refreshIndicatorExtent,
          builder: widget.indicatorBuilder,
        ),
        SliverSafeArea(
          sliver: _buildList(children),
        ),
      ],
    );
  }

  @override
  void onUpdateState(SwipeRefreshState state) {
    if (state == SwipeRefreshState.loading) {
      _scrollController.jumpTo(-(widget.refreshTriggerPullDistance + 5));
    }

    if (state == SwipeRefreshState.hidden) {
      if (completer != null) {
        completer.complete();
        completer = null;
      }
    }
  }

  Widget _buildList(List<Widget> children) {
    if (widget.padding != null)
      return SliverPadding(
        padding: widget.padding,
        sliver: SliverList(
          delegate: widget.childrenDelegate == null
              ? SliverChildListDelegate(
                  children,
                )
              : widget.childrenDelegate,
        ),
      );
    return SliverList(
      delegate: widget.childrenDelegate == null
          ? SliverChildListDelegate(
              children,
            )
          : widget.childrenDelegate,
    );
  }
}
