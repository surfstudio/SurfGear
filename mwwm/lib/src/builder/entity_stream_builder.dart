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
        final streamData = snapshot.data;
        if (streamData == null || streamData.isLoading) {
          return loadingChild;
        }

        if (streamData.hasError) {
          return errorChild;
        }

        return child(context, streamData.data);
      },
    );
  }
}
