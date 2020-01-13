import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart' as w;
import 'package:flutter_template/config/config.dart';
import 'package:flutter_template/config/env/env.dart';
import 'package:flutter_template/domain/debug_options.dart';
import 'package:flutter_template/interactor/common/urls.dart';
import 'package:flutter_template/interactor/debug/debug_screen_interactor.dart';
import 'package:flutter_template/ui/screen/debug/di/debug_screen_component.dart';
import 'package:flutter_template/ui/screen/welcome_screen/welcome_route.dart';
import 'package:injector/injector.dart';
import 'package:mwwm/mwwm.dart';
import 'package:mwwm/mwwm.dart' as m;

enum UrlType { test, prod, dev }

/// Билдер для [DebugWidgetModel].
DebugWidgetModel createDebugWidgetModel(BuildContext context) {
  var component = Injector.of<DebugScreenComponent>(context).component;

  return DebugWidgetModel(
    component.wmDependencies,
    component.navigator,
    component.debugScreenInteractor,
    component.rebuildApplication,
  );
}

/// [WidgetModel] для экрана <Debug>
class DebugWidgetModel extends WidgetModel {
  final w.NavigatorState navigator;
  final DebugScreenInteractor _debugScreenInteractor;
  final w.VoidCallback _rebuildApplication;

  final urlState = StreamedState<UrlType>();
  TextFieldStreamedState proxyValueState;
  final debugOptionsState =
      StreamedState<DebugOptions>(Environment.instance().config.debugOptions);

  final switchServer = m.Action<UrlType>();
  final showDebugNotification = m.Action();
  final closeScreenAction = m.Action();
  final urlChangeAction = m.Action<UrlType>();

  final proxyChanges = TextEditingAction();

  final showPerformanceOverlayChangeAction = m.Action<bool>();
  final debugShowMaterialGridChangeAction = m.Action<bool>();
  final checkerboardRasterCacheImagesChangeAction = m.Action<bool>();
  final checkerboardOffscreenLayersChangeAction = m.Action<bool>();
  final showSemanticsDebuggerChangeAction = m.Action<bool>();
  final debugShowCheckedModeBannerChangeAction = m.Action<bool>();
  final setProxy = m.Action<void>();

  String currentUrl;
  String proxyUrl;

  Config get config => Environment.instance().config;

  set config(Config newConfig) => Environment.instance().config = newConfig;

  DebugWidgetModel(
    WidgetModelDependencies dependencies,
    this.navigator,
    this._debugScreenInteractor,
    this._rebuildApplication,
  ) : super(dependencies);

  @override
  void onLoad() {
    super.onLoad();

    currentUrl = config.url;
    proxyUrl = config.proxyUrl;

    if (currentUrl == Url.testUrl) {
      urlState.accept(UrlType.test);
    } else if (currentUrl == Url.prodUrl) {
      urlState.accept(UrlType.prod);
    } else {
      urlState.accept(UrlType.dev);
    }

    if (proxyUrl != null && proxyUrl.isNotEmpty) {
      proxyValueState = TextFieldStreamedState(proxyUrl);
      proxyChanges.controller.text = proxyUrl;
    } else {
      proxyValueState = TextFieldStreamedState("");
      proxyChanges.controller.text = "";
    }

    bind(switchServer, (urlType) {
      Config newConfig;
      switch (urlType) {
        case UrlType.test:
          newConfig = config.copyWith(url: Url.testUrl);
          break;
        case UrlType.prod:
          newConfig = config.copyWith(url: Url.prodUrl);
          break;
        default:
          newConfig = config.copyWith(url: Url.devUrl);
          break;
      }
      _refreshApp(newConfig);
    });

    subscribe(debugOptionsState.stream, (value) {
      config = config.copyWith(debugOptions: value);
    });

    bind(
      showDebugNotification,
      (_) => _debugScreenInteractor.showDebugScreenNotification(),
    );

    bind(closeScreenAction, (_) {
      showDebugNotification.accept();
      navigator.pop();
    });

    bind(urlChangeAction, (url) => urlState.accept);

    bind(
        showPerformanceOverlayChangeAction,
        (value) => _setDebugOptionState(
              config.debugOptions.copyWith(showPerformanceOverlay: value),
            ));

    bind(
        debugShowMaterialGridChangeAction,
        (value) => _setDebugOptionState(
              config.debugOptions.copyWith(debugShowMaterialGrid: value),
            ));

    bind(
        checkerboardRasterCacheImagesChangeAction,
        (value) => _setDebugOptionState(
              config.debugOptions
                  .copyWith(checkerboardRasterCacheImages: value),
            ));

    bind(
        checkerboardOffscreenLayersChangeAction,
        (value) => _setDebugOptionState(
              config.debugOptions.copyWith(checkerboardOffscreenLayers: value),
            ));

    bind(
        showSemanticsDebuggerChangeAction,
        (value) => _setDebugOptionState(
              config.debugOptions.copyWith(showSemanticsDebugger: value),
            ));

    bind(
        debugShowCheckedModeBannerChangeAction,
        (value) => _setDebugOptionState(
              config.debugOptions.copyWith(debugShowCheckedModeBanner: value),
            ));

    bind(proxyChanges, proxyValueState.content);

    bind(setProxy, (_) => _setProxy());
  }

  void _refreshApp(Config newConfig) {
    config = newConfig;

    _rebuildApplication();

    navigator.pushAndRemoveUntil(WelcomeScreenRoute(), (_) => false);
  }

  void _setProxy() {
    config = config.copyWith(proxyUrl: proxyValueState.value.data);
    _refreshApp(config);
  }

  void _setDebugOptionState(DebugOptions newOpt) {
    config = config.copyWith(debugOptions: newOpt);
    debugOptionsState.accept(newOpt);
  }
}
