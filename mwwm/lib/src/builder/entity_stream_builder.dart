import 'package:flutter/widgets.dart';
import 'package:mwwm/mwwm.dart';

typedef WidgetBuilder<T> = Widget Function(BuildContext, T data);

/// Реактивный виджет для [EntityStreamedState]
///
/// [streamedState] - внешний поток, который управляет состояние виджета
/// виджет имеет 3 состояния:
///   [child] - контент;
///   [loadingChild] - загрузка;
///   [errorChild] - ошибка.
///
/// ### пример
///
/// EntityStateBuilder<Data>(
///      streamedState: wm.dataState,
///      child: (data) => DataWidget(data),
///      loadingChild: LoadingWidget(),
///      errorChild: ErrorPlaceholder(),
///    );
class EntityStateBuilder<T> extends StatelessWidget {
  final EntityStreamedState<T> streamedState;

  final WidgetBuilder<T> child;
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
        final streamData = snapshot.data;
        if (streamData == null ||
            (streamData.data == null && streamData.isLoading)) {
          return loadingChild;
        }

        if (streamData.data != null) {
          return child(context, streamData.data);
        }

        return errorChild;
      },
    );
  }
}
