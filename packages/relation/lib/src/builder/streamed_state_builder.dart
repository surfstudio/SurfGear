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
import 'package:relation/src/relation/state/streamed_state.dart';

typedef StreamedStateWidgetBuilder<T> = Widget Function(
  BuildContext context,
  T data,
);

/// Widget for StreamedState.
class StreamedStateBuilder<T> extends StreamBuilderBase<T, T> {
  StreamedStateBuilder({
    required this.streamedState,
    required this.builder,
    Key? key,
  }) : super(key: key, stream: streamedState.stream);

  /// Input streamed state
  final StreamedState<T> streamedState;

  /// Builder of widget child
  final StreamedStateWidgetBuilder<T> builder;

  @override
  T afterData(T current, T data) => data;

  @override
  T initial() => streamedState.value;

  @override
  Widget build(BuildContext context, T currentSummary) =>
      builder(context, currentSummary);
}
