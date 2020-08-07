import 'package:flutter/widgets.dart' hide Action;
import 'package:flutter_template/config/config.dart';
import 'package:flutter_template/config/env/env.dart';
import 'package:flutter_template/domain/debug_options.dart';
import 'package:flutter_template/interactor/common/urls.dart';
import 'package:flutter_template/interactor/debug/debug_screen_interactor.dart';
import 'package:flutter_template/ui/screen/debug/di/debug_screen_component.dart';
import 'package:flutter_template/ui/screen/welcome_screen/welcome_route.dart';
import 'package:flutter_template/util/const.dart';
import 'package:injector/injector.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

enum UrlType { test, prod, dev }

/// Билдер для [DebugWidgetModel].
DebugWidgetModel createDebugWidgetModel(BuildContext context) {
  final component = Injector.of<DebugScreenComponent>(context).component;

  return DebugWidgetModel(
    component.wmDependencies,
    component.navigator,
    component.debugScreenInteractor,
    component.rebuildApplication,
  );
}

/// [WidgetModel] для экрана <Debug>
class DebugWidgetModel extends WidgetModel {
  DebugWidgetModel(
    WidgetModelDependencies dependencies,
    this.navigator,
    this._debugScreenInteractor,
    this._rebuildApplication,
  ) : super(dependencies);

  final NavigatorState navigator;
  final DebugScreenInteractor _debugScreenInteractor;
  final VoidCallback _rebuildApplication;

  final urlState = StreamedState<UrlType>();
  TextFieldStreamedState proxyValueState;
  final debugOptionsState = StreamedState<DebugOptions>(
    Environment<Config>.instance().config.debugOptions,
  );

  final switchServer = Action<UrlType>();
  final showDebugNotification = Action<void>();
  final closeScreenAction = Action<void>();
  final urlChangeAction = Action<UrlType>();

  final proxyChanges = TextEditingAction();

  final showPerformanceOverlayChangeAction = Action<bool>();
  final debugShowMaterialGridChangeAction = Action<bool>();
  final checkerboardRasterCacheImagesChangeAction = Action<bool>();
  final checkerboardOffscreenLayersChangeAction = Action<bool>();
  final showSemanticsDebuggerChangeAction = Action<bool>();
  final debugShowCheckedModeBannerChangeAction = Action<bool>();
  final setProxy = Action<void>();

  String currentUrl;
  String proxyUrl;

  Config get config => Environment<Config>.instance().config;

  set config(Config newConfig) =>
      Environment<Config>.instance().config = newConfig;

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
      proxyValueState = TextFieldStreamedState(emptyString);
      proxyChanges.controller.text = emptyString;
    }

    bind<UrlType>(
      switchServer,
      (urlType) {
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
      },
    );

    subscribe<DebugOptions>(
      debugOptionsState.stream,
      (value) {
        config = config.copyWith(debugOptions: value);
      },
    );

    bind<void>(
      showDebugNotification,
      (_) => _debugScreenInteractor.showDebugScreenNotification(),
    );

    bind<void>(
      closeScreenAction,
      (_) {
        showDebugNotification.accept();
        navigator.pop();
      },
    );

    bind(urlChangeAction, urlState.accept);

    bind<bool>(
      showPerformanceOverlayChangeAction,
      (value) => _setDebugOptionState(
        config.debugOptions.copyWith(showPerformanceOverlay: value),
      ),
    );

    bind<bool>(
      debugShowMaterialGridChangeAction,
      (value) => _setDebugOptionState(
        config.debugOptions.copyWith(debugShowMaterialGrid: value),
      ),
    );

    bind<bool>(
      checkerboardRasterCacheImagesChangeAction,
      (value) => _setDebugOptionState(
        config.debugOptions.copyWith(checkerboardRasterCacheImages: value),
      ),
    );

    bind<bool>(
      checkerboardOffscreenLayersChangeAction,
      (value) => _setDebugOptionState(
        config.debugOptions.copyWith(checkerboardOffscreenLayers: value),
      ),
    );

    bind<bool>(
      showSemanticsDebuggerChangeAction,
      (value) => _setDebugOptionState(
        config.debugOptions.copyWith(showSemanticsDebugger: value),
      ),
    );

    bind<bool>(
      debugShowCheckedModeBannerChangeAction,
      (value) => _setDebugOptionState(
        config.debugOptions.copyWith(debugShowCheckedModeBanner: value),
      ),
    );

    bind(proxyChanges, proxyValueState.content);

    bind<void>(
      setProxy,
      (_) => _setProxy(),
    );
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
