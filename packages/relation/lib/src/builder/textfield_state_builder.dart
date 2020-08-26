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
import 'package:relation/src/builder/streamed_state_builder.dart';
import 'package:relation/src/relation/event.dart';
import 'package:relation/src/relation/state/entity_state.dart';
import 'package:relation/src/relation/state/streamed_state.dart';

/// Stream builder for text fields
class TextFieldStateBuilder extends StatelessWidget {
  const TextFieldStateBuilder({
    Key key,
    this.state,
    this.stateBuilder,
  }) : super(key: key);

  /// State of text field
  final TextFieldStreamedState state;

  /// Builder of state
  final Widget Function(BuildContext, TextFieldState) stateBuilder;

  @override
  Widget build(BuildContext context) {
    return StreamedStateBuilder<TextFieldState>(
      streamedState: state,
      builder: stateBuilder,
    );
  }
}

/// Text field state
/// can:
///   - loading
///   - error
///   - disable
///   - content
/// todo come up with how to combine with the controller
class TextFieldState extends EntityState<String> {
  /// Content constructor
  TextFieldState.content(this.data)
      : isEnabled = true,
        super.content(data);

  /// Error constructor
  TextFieldState.error(this.data, [Exception e])
      : isEnabled = true,
        super.error(e);

  /// Loading constructor
  TextFieldState.loading()
      : isEnabled = false,
        data = '',
        super.loading();

  /// Enabled constructor
  TextFieldState.enabled(this.data, {bool enabled = true})
      : isEnabled = enabled,
        super.content(data);

  /// Text field is enabled
  final bool isEnabled;

  @override
  // ignore: overridden_fields
  final String data;
}

/// Stream view of text field state
/// For validations, it is possible to set restrictions such as [validator],
/// [mandatory], [canEdit]
class TextFieldStreamedState extends StreamedState<TextFieldState>
    implements EntityEvent<String> {
  TextFieldStreamedState(
    String initialData, {
    String validator = '',
    this.mandatory = false,
    this.canEdit = true,
    this.incorrectTextMsg = '',
  })  : validator = RegExp(validator),
        super(TextFieldState.enabled(initialData, enabled: canEdit));

  /// Validator of regex
  final RegExp validator;

  /// Is required for fill
  final bool mandatory;

  /// is can edit text
  final bool canEdit;

  /// Text of error
  final String incorrectTextMsg;

  @override
  Future<void> content([String data]) {
    if (!validator.hasMatch(data) || (data.isEmpty && mandatory)) {
      return super.accept(
        TextFieldState.error(
          data,
          IncorrectTextException(incorrectTextMsg),
        ),
      );
    } else if (!canEdit) {
      return accept(TextFieldState.enabled(value.data, enabled: canEdit));
    } else {
      return super.accept(TextFieldState.content(data));
    }
  }

  @override
  Future<void> error([Exception error]) {
    final state = TextFieldState.error(value.data, error);
    return super.accept(state);
  }

  @override
  Future<void> loading() {
    final state = TextFieldState.loading();
    return super.accept(state);
  }
}

/// Exception of incorrect text wrapper
class IncorrectTextException implements Exception {
  IncorrectTextException(this.message);

  final String message;
}
