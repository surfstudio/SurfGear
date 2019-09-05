import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';

/// Widget for StreamedState.
/// Wrap Flutter StreamBuilder
class StreamedStateBuilder<T> extends StatelessWidget {
  /// Input streamed state
  final StreamedState<T> streamedState;

  /// Builder of widget child
  final Widget Function(BuildContext, T) builder;

  const StreamedStateBuilder({
    Key key,
    @required this.streamedState,
    @required this.builder,
  })  : assert(streamedState != null && builder != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      builder: (ctx, snapshot) => builder(ctx, snapshot.data),
      stream: streamedState.stream,
      initialData: streamedState.value,
    );
  }
}
