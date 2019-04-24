import 'package:flutter/material.dart';
import 'package:flutter_template/ui/app/di/app.dart';
import 'package:flutter_template/ui/base/default_dialog_controller.dart';
import 'package:flutter_template/ui/base/error/standard_error_handler.dart';
import 'package:flutter_template/ui/base/material_message_controller.dart';
import 'package:flutter_template/ui/screen/phone_input/phone_input_wm.dart';
import 'package:mwwm/mwwm.dart';

class PhoneInputScreenComponent
    implements BaseWidgetModelComponent<PhoneInputWidgetModel> {
  @override
  PhoneInputWidgetModel wm;

  PhoneInputScreenComponent(
    AppComponent parentComponent,
    Key scaffoldKey,
    NavigatorState navigator,
  ) {
    final wmDependencies = WidgetModelDependencies(
      errorHandler: StandardErrorHandler(
        MaterialMessageController(scaffoldKey),
        DefaultDialogController(scaffoldKey),
      ),
      navigator: navigator,
    );

    wm = PhoneInputWidgetModel(
      wmDependencies,
      navigator,
      parentComponent.counterInteractor,
    );
  }
}
