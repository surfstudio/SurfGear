import 'package:flutter/material.dart';
import 'package:flutter_template/interactor/counter/counter_interactor.dart';
import 'package:flutter_template/ui/app/di/app.dart';
import 'package:flutter_template/ui/base/default_dialog_controller.dart';
import 'package:flutter_template/ui/base/error/standard_error_handler.dart';
import 'package:flutter_template/ui/base/material_message_controller.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:mwwm/mwwm.dart';

/// [Component] для экрана <Welcome>
class WelcomeScreenComponent implements Component {
  WelcomeScreenComponent(BuildContext context) {
    final app = Injector.of<AppComponent>(context).component;

    messageController = MaterialMessageController(scaffoldKey);
    dialogController = DefaultDialogController(scaffoldKey);
    navigator = Navigator.of(context);

    wmDependencies = WidgetModelDependencies(
      errorHandler: StandardErrorHandler(
        messageController,
        dialogController,
        app.scInteractor,
      ),
    );

    counterInteractor = app.counterInteractor;
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  MaterialMessageController messageController;
  DefaultDialogController dialogController;
  NavigatorState navigator;
  WidgetModelDependencies wmDependencies;

  CounterInteractor counterInteractor;
}
