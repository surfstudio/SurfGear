import 'package:flutter/widgets.dart';
import 'package:mwwm/mwwm.dart';

typedef DataWidgetBuilder<T> = Widget Function(BuildContext, T data);

/// Reactive widget for [EntityStreamedState]
///
/// [streamedState] - external stream that controls the state of the widget
/// widget has three states:
///   [child] - content;
///   [loadingChild] - loading;
///   [errorChild] - error.
///
/// ### example
/// ```dart
/// EntityStateBuilder<Data>(
///      streamedState: wm.dataState,
///      child: (data) => DataWidget(data),
///      loadingChild: LoadingWidget(),
///      errorChild: ErrorPlaceholder(),
///    );
///  ```
class EntityStateBuilder<T> extends StatelessWidget {
  final EntityStreamedState<T> streamedState;

  final DataWidgetBuilder<T> child;
  final Widget loadingChild;
  final Widget errorChild;

  const EntityStateBuilder({
    Key key,
    @required this.streamedState,
    @required this.child,
    @required this.loadingChild,
    @required this.errorChild,
  })  : assert(streamedState != null),
        assert(child != null),
        assert(loadingChild != null),
        assert(errorChild != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<EntityState<T>>(
      stream: streamedState.stream,
      initialData: streamedState.value,
      builder: (context, snapshot) {
        final streamData = snapshot._data;
        if (streamData == null || streamData.isLoading) {
          return loadingChild;
        }

        if (streamData.hasError) {
          return errorChild;
        }

        return child(context, streamData._data);
      },
    );
  }
}
