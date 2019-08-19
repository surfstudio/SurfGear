import 'package:flutter/widgets.dart';
import 'package:mwwm/mwwm.dart';

/// Стрим билдер для текстовых полей
class TextFieldStateBuilder extends StatelessWidget {
  final TextFieldStreamedState state;
  final Widget Function(BuildContext, TextFieldState) stateBuilder;

  const TextFieldStateBuilder({
    Key key,
    this.state,
    this.stateBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamedStateBuilder<TextFieldState>(
      streamedState: state,
      builder: stateBuilder,
    );
  }
}

/// Стейт текстового поля
/// поддержка
///   - загрузки
///   - ошибки
///   - дизейбла
///   - данных
/// todo подумать над объединением с контроллером
class TextFieldState extends EntityState<String> {
  final bool isEnabled;
  final String data;

  TextFieldState.content(String data)
      : isEnabled = true,
        this.data = data,
        super.content(data);

  TextFieldState.error(String oldData, [Exception e])
      : isEnabled = true,
        this.data = oldData,
        super.error(e);

  TextFieldState.loading()
      : isEnabled = false,
        data = "",
        super.loading();

  TextFieldState.enabled(String oldData, [bool enabled = true])
      : isEnabled = enabled,
        data = oldData,
        super.content(oldData);
}

/// Потоковое представление состояния текстового поля
/// Для валидаций есть возможность задать ограничения такие как [validator],
/// [mandatory], [canEdit]
class TextFieldStreamedState extends StreamedState<TextFieldState>
    implements EntityEvent<String> {
  final RegExp validator;
  final bool mandatory;
  final bool canEdit;
  final String incorrectTextMsg;

  TextFieldStreamedState(
    String initialData, {
    Pattern validator = r'',
    this.mandatory = false,
    this.canEdit = true,
    this.incorrectTextMsg = "",
  })  : validator = RegExp(validator),
        super(TextFieldState.enabled(initialData, canEdit));

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
      return accept(TextFieldState.enabled(value.data, canEdit));
    } else {
      return super.accept(TextFieldState.content(data));
    }
  }

  @override
  Future<void> error([Exception error]) {
    var state = TextFieldState.error(value.data, error);
    return super.accept(state);
  }

  @override
  Future<void> loading() {
    var state = TextFieldState.loading();
    return super.accept(state);
  }
}

class IncorrectTextException implements Exception {
  final String message;

  IncorrectTextException(this.message);
}
