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
import 'package:relation/src/relation/state/entity_state.dart';

typedef DataWidgetBuilder<T> = Widget Function(BuildContext context, T? data);
typedef ErrorWidgetBuilder = Widget Function(BuildContext context, Exception e);
typedef DataWidgetErrorBuilder<T> = Widget Function(
  BuildContext context,
  T? data,
  Exception e,
);

/// Reactive widget for [EntityStreamedState]
///
/// [streamedState] - external stream that controls the state of the widget
/// widget has three states:
///   [builder] - content;
///   [loadingChild] - loading;
///   [errorChild] - error.
///
/// ### example
/// ```dart
/// EntityStateBuilder<Data>(
///      streamedState: wm.dataState,
///      builder: (data) => DataWidget(data),
///      loadingChild: LoadingWidget(),
///      errorChild: ErrorPlaceholder(),
///    );
///  ```
class EntityStateBuilder<T> extends StatelessWidget {
  const EntityStateBuilder({
    required this.streamedState,
    required this.builder,
    this.loadingBuilder,
    this.errorDataBuilder,
    this.errorBuilder,
    this.loadingChild = const SizedBox(),
    this.errorChild = const SizedBox(),
    Key? key,
  }) : super(key: key);

  /// StreamedState of entity
  final EntityStreamedState<T> streamedState;

  /// Returns [Widget] depend on [streamedState]'s data
  final DataWidgetBuilder<T> builder;

  /// Loading child of builder
  final DataWidgetBuilder<T>? loadingBuilder;

  /// Error child of builder with previous data
  final DataWidgetErrorBuilder<T>? errorDataBuilder;

  /// Error child of builder
  final ErrorWidgetBuilder? errorBuilder;

  /// Loading child widget
  final Widget loadingChild;

  /// Error child widget
  final Widget errorChild;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<EntityState<T>?>(
      stream: streamedState.stream,
      initialData: streamedState.value,
      builder: (context, snapshot) {
        final streamData = snapshot.data;
        if (streamData == null || streamData.isLoading) {
          if (loadingBuilder != null) {
            return loadingBuilder!(context, streamData?.data);
          } else {
            return loadingChild;
          }
        } else if (streamData.hasError) {
          final exception = streamData.error?.e != null
              ? streamData.error!.e as Exception
              : Exception();

          if (errorDataBuilder != null) {
            return errorDataBuilder!(context, streamData.data, exception);
          } else {
            if (errorBuilder != null) {
              return errorBuilder!(context, exception);
            }
            return errorChild;
          }
        } else if (streamData.data != null) {
          return builder(context, streamData.data);
        }

        return errorChild;
      },
    );
  }
}
