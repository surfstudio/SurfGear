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
  DialogBuilder(this.builder);

  final Widget Function(BuildContext context, {T data}) builder;

  Widget call(BuildContext context, {DialogData data}) => builder(
        context,
        data: data as T,
      );
}

/// Возвращает виджет для тянущегося боттом шита с контентом в виде списка
/// scrollController - контроллер прокрутки на боттомшите,
/// передается в дочерний список
class FlexibleDialogBuilder<T extends DialogData> extends DialogBuilder<T> {
  FlexibleDialogBuilder(this.builder) : super(builder);

  @override
  Widget Function(
    BuildContext context, {
    T data,
    ScrollController scrollController,
    // ignore: overridden_fields
  }) builder;

  @override
  Widget call(
    BuildContext context, {
    DialogData data,
    ScrollController scrollController,
  }) =>
      builder(context, data: data as T, scrollController: scrollController);
}

/// Миксин, добавляющий возможности зарегистрировать диалоги
mixin DialogOwner {
  Map<dynamic, DialogBuilder> get registeredDialogs;
}
