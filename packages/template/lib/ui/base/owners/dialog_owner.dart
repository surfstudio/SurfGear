import 'package:flutter/widgets.dart';
import 'package:mwwm/mwwm.dart' show DialogData;

/// Возвращает виджет для диалога или боттом шита.
/// Пример:
///
/// ```dart
/// @override
/// Map<dynamic, DialogBuilder> get registeredDialogs => {
///   "dialogType1": DialogBuilder<FooDialogData>(_buildType1Dialog),
///   "dialogType2": DialogBuilder<BarDialogData>(_buildType2Dialog),
/// };
///
/// Widget _buildType1Dialog(BuildContext context, {FooDialogData data}) {/* ... */}
/// ```
class DialogBuilder<T extends DialogData> {
  final Widget Function(BuildContext context, {T data}) builder;

  DialogBuilder(this.builder);

  call(BuildContext context, {DialogData data}) => builder(context, data: data);
}

/// Возвращает виджет для тянущегося боттом шита с контентом в виде списка
/// [scrollController] - контроллер прокрутки на боттомшите,
/// передается в дочерний спиоок
class FlexibleDialogBuilder<T extends DialogData> extends DialogBuilder<T> {
  @override
  Widget Function(
    BuildContext context, {
    T data,
    ScrollController scrollController,
  }) builder;

  FlexibleDialogBuilder(this.builder) : super(builder);

  call(
    BuildContext context, {
    DialogData data,
    ScrollController scrollController,
  }) =>
      builder(context, data: data, scrollController: scrollController);
}

/// Миксин, добавляющий возможност зарегистрировать диалоги
mixin DialogOwner {
  Map<dynamic, DialogBuilder> get registeredDialogs;
}
