import 'package:flutter/material.dart';
import 'package:flutter_template/interactor/debug/debug_screen_interactor.dart';
import 'package:flutter_template/ui/app/di/app.dart';
import 'package:flutter_template/ui/base/default_dialog_controller.dart';
import 'package:flutter_template/ui/base/error/standard_error_handler.dart';
import 'package:flutter_template/ui/base/material_message_controller.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:mwwm/mwwm.dart';

/// [Component] для экрана <Debug>
class DebugScreenComponent implements Component {
  DebugScreenComponent(BuildContext context) {
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

    debugScreenInteractor = app.debugScreenInteractor;
    rebuildApplication = app.rebuildDependencies;
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  MessageController messageController;
  DialogController dialogController;
  NavigatorState navigator;
  WidgetModelDependencies wmDependencies;
  DebugScreenInteractor debugScreenInteractor;
  VoidCallback rebuildApplication;
}
