import 'package:flutter/widgets.dart' as w;
import 'package:flutter_template/config/config.dart';
import 'package:flutter_template/config/env/env.dart';
import 'package:flutter_template/domain/debug_options.dart';
import 'package:flutter_template/interactor/auth/auth_interactor.dart';
import 'package:flutter_template/interactor/common/urls.dart';
import 'package:flutter_template/interactor/debug/debug_screen_interactor.dart';
import 'package:flutter_template/ui/screen/phone_input/phone_route.dart';
import 'package:mwwm/mwwm.dart';

enum UrlType { test, prod, dev }

/// [WidgetModel] для экрана <Debug>
class DebugWidgetModel extends WidgetModel {
  DebugWidgetModel(
    WidgetModelDependencies dependencies,
    this.navigator,
    this._authInteractor,
    this._debugScreenInteractor,
  ) : super(dependencies);

  final w.NavigatorState navigator;
  final AuthInteractor _authInteractor;
  final DebugScreenInteractor _debugScreenInteractor;

  final urlState = StreamedState<UrlType>();
  TextFieldStreamedState proxyValueState;
  final debugOptionsState =
      StreamedState<DebugOptions>(Environment.instance().config.debugOptions);

  final switchServer = Action<UrlType>();
  final showDebugNotification = Action();
  final closeScreenAction = Action();
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

  Config get config => Environment.instance().config;

  set config(Config newConfig) => Environment.instance().config = newConfig;

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
    subscribeHandleError(_authInteractor.logOut(), (_) {
      config = newConfig;
      navigator.pushAndRemoveUntil(PhoneInputRoute(), (_) => false);
    });
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
