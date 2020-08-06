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
