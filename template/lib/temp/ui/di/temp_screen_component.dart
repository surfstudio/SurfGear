/// Copyright (c) 2019-present,  SurfStudio LLC
/// 
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
/// 
///     http://www.apache.org/licenses/LICENSE-2.0
/// 
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.

import 'package:flutter/material.dart';
import 'package:flutter_template/temp/ui/temp_wm.dart';
import 'package:flutter_template/ui/app/di/app.dart';
import 'package:flutter_template/ui/base/default_dialog_controller.dart';
import 'package:flutter_template/ui/base/error/standard_error_handler.dart';
import 'package:flutter_template/ui/base/material_message_controller.dart';
import 'package:mwwm/mwwm.dart';

/// [Component] для экрана <todo>
class TempScreenComponent implements BaseWidgetModelComponent<TempWidgetModel> {
  @override
  TempWidgetModel wm;

  TempScreenComponent(
    AppComponent parentComponent,
    Key scaffoldKey,
    NavigatorState navigator,
  ) {
    final wmDependencies = WidgetModelDependencies(
      errorHandler: StandardErrorHandler(
        MaterialMessageController(scaffoldKey),
        DefaultDialogController(scaffoldKey),
        parentComponent.scInteractor,
      ),
    );

    wm = TempWidgetModel(
      wmDependencies,
      navigator,
    );
  }
}
