import 'package:flutter/cupertino.dart';
import 'package:relation/relation.dart';
import 'package:swipe_refresh/swipe_refresh.dart';

/// Cupertino style Refresh indicator widget based on [StreamedState].
class StreamedCupertinoSwipeRefresh extends CupertinoSwipeRefresh {
  StreamedCupertinoSwipeRefresh({
    @required List<Widget> children,
    @required StreamedState<SwipeRefreshState> stateStream,
    @required VoidCallback onRefresh,
    Key key,
  }) : super(
          key: key,
          children: children,
          onRefresh: onRefresh,
          stateStream: stateStream.stream,
          initState: stateStream.value,
        );
}
