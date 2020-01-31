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
  // final ScrollController scrollController;

  const CupertinoSwipeRefresh({
    Key key,
    List<Widget> children,
    Stream<SwipeRefreshState> stateStream,
    SwipeRefreshState initState,
    VoidCallback onRefresh,
    this.refreshTriggerPullDistance = DEFAULT_REFRESH_TRIGGER_PULL_DISTANCE,
    this.refreshIndicatorExtent = DEFAULT_REFRESH_INDICATOR_EXTENT,
    this.indicatorBuilder =
        CupertinoSliverRefreshControl.buildSimpleRefreshIndicator,
    ScrollController scrollController,
  }) : super(
            key: key,
            children: children,
            stateStream: stateStream,
            initState: initState,
            scrollController: scrollController,
            onRefresh: onRefresh);

  @override
  SwipeRefreshBaseState createState() => _CupertinoSwipeRefreshState();
}

class _CupertinoSwipeRefreshState
    extends SwipeRefreshBaseState<CupertinoSwipeRefresh> {
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController ?? ScrollController();
  }

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
          sliver: SliverList(
            delegate: SliverChildListDelegate(
              children,
            ),
          ),
        )
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
}
