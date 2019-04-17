import 'package:flutter/material.dart';
import 'package:flutter_template/ui/app/di/app.dart';
import 'package:injector/injector.dart';
import 'package:flutter_template/interactor/counter/counter_interactor.dart';
import 'package:flutter_template/ui/base/dependency/widget_model_dependencies.dart';
import 'package:flutter_template/ui/base/impl/material_message_controller.dart';
import 'package:flutter_template/ui/base/impl/standard_error_handler.dart';
import 'package:flutter_template/ui/screen/phone_input/phone_input_wm.dart';

class PhoneInputScreenComponent extends Component {
  List<Module> _list = List();

  PhoneInputScreenComponent(
    AppComponent parentComponent,
    Key scaffoldKey,
    NavigatorState navigator,
  ) {
    _list.add(PhoneInputModelModule(
      parentComponent.get(CounterInteractor),
      scaffoldKey,
      navigator,
    ));
  }

  @override
  List<Module> getModules() {
    return _list;
  }
}

class PhoneInputModelModule extends Module<PhoneInputWidgetModel> {
  PhoneInputWidgetModel _model;

  PhoneInputModelModule(
    CounterInteractor _counterInteractor,
    Key scaffoldKey,
    NavigatorState navigator,
  ) {
    _model = PhoneInputWidgetModel(
      WidgetModelDependencies(
        errorHandler: StandardErrorHandler(
          MaterialMessageController(scaffoldKey),
          navigator,
        ),
        navigator: navigator,
      ),
      navigator,
      _counterInteractor,
    );
  }

  @override
  PhoneInputWidgetModel provides() {
    return _model;
  }
}
