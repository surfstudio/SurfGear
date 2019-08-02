import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:name_generator/interactor/name_generator/name_generator_interactor.dart';
import 'package:name_generator/interactor/name_generator/repository/name_generator_repository.dart';
import 'package:name_generator/interactor/network/status_mapper.dart';
import 'package:name_generator/interactor/session/session_changed_interactor.dart';
import 'package:name_generator/ui/app/app_wm.dart';
import 'package:name_generator/ui/base/default_dialog_controller.dart';
import 'package:name_generator/ui/base/error/standard_error_handler.dart';
import 'package:name_generator/ui/base/material_message_controller.dart';
import 'package:network/network.dart';

/// Component для приложения
class AppComponent implements BaseWidgetModelComponent<AppWidgetModel> {
  AppWidgetModel wm;

  RxHttp http;
  SessionChangedInteractor scInteractor;

  NameGeneratorInteractor nameGeneratorInteractor;

  AppComponent(
    GlobalKey<NavigatorState> navigatorKey,
    GlobalKey<ScaffoldState> scaffoldKey,
  ) {
    http = _initHttp();
    nameGeneratorInteractor =
        NameGeneratorInteractor(NameGeneratorRepository(http));

    final messageController = MaterialMessageController(scaffoldKey);
    final wmDependencies = WidgetModelDependencies(
      errorHandler: StandardErrorHandler(
        messageController,
        DefaultDialogController(scaffoldKey),
        scInteractor,
      ),
    );
    wm = AppWidgetModel(wmDependencies, messageController, navigatorKey);
  }

  RxHttp _initHttp() {
    var dioHttp = DioHttp(
      config: HttpConfig(
        'https://uinames.com/api/?ext',
        Duration(seconds: 30),
      ),
      errorMapper: DefaultStatusMapper(),
    );
    return RxHttpDelegate(dioHttp);
  }
}
