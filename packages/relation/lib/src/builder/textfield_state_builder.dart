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
    required this.state,
    required this.stateBuilder,
    Key? key,
  }) : super(key: key);

  /// State of text field
  final TextFieldStreamedState state;

  /// Builder of state
  final Widget Function(BuildContext, TextFieldState?) stateBuilder;

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
  TextFieldState.content(String data)
      : isEnabled = true,
        super.content(data);

  /// Error constructor
  TextFieldState.error(String? data, [Exception? e])
      : isEnabled = true,
        super.error(e, data);

  /// Loading constructor
  TextFieldState.loading()
      : isEnabled = false,
        super.loading('');

  /// Enabled constructor
  TextFieldState.enabled(String? data, {bool enabled = true})
      : isEnabled = enabled,
        super.content(data);

  /// Text field is enabled
  final bool isEnabled;
}

/// Stream view of text field state
/// For validations, it is possible to set restrictions such as [validator],
/// [mandatory], [canEdit]
class TextFieldStreamedState extends StreamedState<TextFieldState>
    implements EntityEvent<String, TextFieldState> {
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
  Future<void> content(String data) {
    if (!validator.hasMatch(data) || (data.isEmpty && mandatory)) {
      return accept(
        TextFieldState.error(
          data,
          IncorrectTextException(incorrectTextMsg),
        ),
      );
    } else if (!canEdit) {
      return accept(TextFieldState.enabled(value.data, enabled: canEdit));
    } else {
      return accept(TextFieldState.content(data));
    }
  }

  @override
  Future<void> error([Exception? error]) =>
      accept(TextFieldState.error(value.data, error));

  @override
  Future<void> loading() => accept(TextFieldState.loading());
}

/// Exception of incorrect text wrapper
class IncorrectTextException implements Exception {
  const IncorrectTextException(this.message);

  final String message;
}
