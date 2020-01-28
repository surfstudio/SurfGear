import 'package:flutter/cupertino.dart';
import 'package:mwwm/mwwm.dart';
import 'package:swipe_refresh/swipe_refresh.dart';

/// Cupertino style Refresh indicator widget based on [StreamedState].
class StreamedCupertinoSwipeRefresh extends CupertinoSwipeRefresh {
  StreamedCupertinoSwipeRefresh({
    Key key,
    @required List<Widget> children,
    @required StreamedState<SwipeRefreshState> stateStream,
    @required VoidCallback onRefresh,
    Color indicatorColor,
    Color backgroundColor,
  }) : super(
          key: key,
          children: children,
          onRefresh: onRefresh,
          stateStream: stateStream.stream,
          initState: stateStream.value,
        );
}
