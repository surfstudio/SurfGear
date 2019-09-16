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
