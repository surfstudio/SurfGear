import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mwwm/mwwm.dart';
import 'package:swipe_refresh/swipe_refresh.dart';

/// Material Design style Refresh indicator widget based on [StreamedState].
class StreamedMaterialSwipeRefresh extends MaterialSwipeRefresh {
  StreamedMaterialSwipeRefresh({
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
          indicatorColor: indicatorColor,
          backgroundColor: backgroundColor,
        );
}
