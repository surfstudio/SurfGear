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

///Базовый класс контроллера отображения диалогов
abstract class DialogController {
  Future<R> showAlertDialog<R>({
    String title,
    String message,
    void Function(BuildContext context) onAgreeClicked,
    void Function(BuildContext context) onDisagreeClicked,
  });

  Future<R> showSheet<R>(
    dynamic type, {
    VoidCallback onDismiss,
    DialogData data,
  });

  Future<R> showModalSheet<R>(
    dynamic type, {
    DialogData data,
    bool isScrollControlled,
  });
}

/// Параметры диалога
abstract class DialogData {}
