import 'package:flutter/material.dart';
import 'package:flutter_template/ui/app/di/app.dart';
import 'package:flutter_template/ui/base/default_dialog_controller.dart';
import 'package:flutter_template/ui/base/error/standard_error_handler.dart';
import 'package:flutter_template/ui/base/material_message_controller.dart';
import 'package:flutter_template/ui/screen/debug/debug_wm.dart';
import 'package:mwwm/mwwm.dart';

/// [Component] для экрана <Debug>
class DebugScreenComponent
    implements BaseWidgetModelComponent<DebugWidgetModel> {
  @override
  DebugWidgetModel wm;

  DebugScreenComponent(
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

    wm = DebugWidgetModel(
      wmDependencies,
      navigator,
      parentComponent.authInteractor,
      parentComponent.pushHandler,
    );
  }
}
