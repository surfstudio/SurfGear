import 'dart:async';

import 'package:flutter/material.dart';
import 'package:swipe_refresh/src/swipe_refresh_state.dart';

/// Base refresh indicator widget.
abstract class SwipeRefreshBase extends StatefulWidget {
  final List<Widget> children;
  final VoidCallback onRefresh;
  final SwipeRefreshState initState;
  final Stream<SwipeRefreshState> stateStream;

  const SwipeRefreshBase({
    Key key,
    @required this.children,
    @required this.stateStream,
    @required this.onRefresh,
    this.initState,
  })  : assert(children != null),
        assert(stateStream != null),
        assert(onRefresh != null),
        super(key: key);

  @protected
  SwipeRefreshBaseState createState();
}

abstract class SwipeRefreshBaseState<T extends SwipeRefreshBase>
    extends State<T> {
  @protected
  Completer<void> completer;
  @protected
  final GlobalKey refreshKey = GlobalKey();

  SwipeRefreshState _currentState = SwipeRefreshState.hidden;

  @override
  void initState() {
    super.initState();

    if (widget.initState != null) {
      _currentState = widget.initState;
    }

    widget.stateStream.listen(_updateState);
  }

  @override
  Widget build(BuildContext context) {
    return buildRefresher(refreshKey, widget.children, _onRefresh);
  }

  @protected
  Widget buildRefresher(
    Key key,
    List<Widget> children,
    Future<void> Function() onRefresh,
  );

  @protected
  void onUpdateState(SwipeRefreshState state);

  void _updateState(SwipeRefreshState newState) {
    if (_currentState != newState) {
      setState(
        () {
          _currentState = newState;

          onUpdateState(_currentState);
        },
      );
    }
  }

  @protected
  Future<void> _onRefresh() {
    _currentState = SwipeRefreshState.loading;
    widget.onRefresh();
    completer = Completer<void>();
    return completer.future;
  }
}
