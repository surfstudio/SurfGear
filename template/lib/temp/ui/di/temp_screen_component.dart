import 'package:flutter/material.dart';
import 'package:flutter_template/ui/base/default_dialog_controller.dart';
import 'package:flutter_template/ui/base/material_message_controller.dart';
import 'package:injector/injector.dart';
import 'package:mwwm/mwwm.dart';

/// [Component] для экрана <todo>
class TempScreenComponent implements Component {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  MessageController messageController;
  DialogController dialogController;
  NavigatorState navigator;

  TempScreenComponent(BuildContext context) {
    messageController = MaterialMessageController(scaffoldKey);
    dialogController = DefaultDialogController(scaffoldKey);
    navigator = Navigator.of(context);
  }
}