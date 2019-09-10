import 'package:flutter/widgets.dart' as w;
import 'package:flutter_template/config/config.dart';
import 'package:flutter_template/config/env/env.dart';
import 'package:flutter_template/domain/debug_options.dart';
import 'package:flutter_template/interactor/auth/auth_interactor.dart';
import 'package:flutter_template/interactor/common/urls.dart';
import 'package:flutter_template/ui/screen/debug/debug_route.dart';
import 'package:flutter_template/ui/screen/phone_input/phone_route.dart';
import 'package:mwwm/mwwm.dart';
import 'package:push/push.dart';

enum UrlType { test, prod, dev }

/// [WidgetModel] для экрана <Debug>
class DebugWidgetModel extends WidgetModel {
  DebugWidgetModel(
    WidgetModelDependencies dependencies,
    this.navigator,
    this._authInteractor,
    this._pushHandler,
  ) : super(dependencies);

  final w.NavigatorState navigator;
  final AuthInteractor _authInteractor;
  final PushHandler _pushHandler;

  final urlState = StreamedState<UrlType>();
  final debugOptionsState =
      StreamedState<DebugOptions>(Environment.instance().config.debugOptions);

  final switchServer = Action<UrlType>();
  final showDebugNotification = Action();
  final closeScreenAction = Action();
  final urlChangeAction = Action<UrlType>();

  final showPerformanceOverlayChangeAction = Action<bool>();
  final debugShowMaterialGridChangeAction = Action<bool>();
  final checkerboardRasterCacheImagesChangeAction = Action<bool>();
  final checkerboardOffscreenLayersChangeAction = Action<bool>();
  final showSemanticsDebuggerChangeAction = Action<bool>();
  final debugShowCheckedModeBannerChangeAction = Action<bool>();

  String currentUrl;

  Config get config => Environment.instance().config;

  set config(Config newConfig) => Environment.instance().config = newConfig;

  @override
  void onLoad() {
    super.onLoad();

    currentUrl = config.url;
    if (currentUrl == Url.testUrl) {
      urlState.accept(UrlType.test);
    } else if (currentUrl == Url.prodUrl) {
      urlState.accept(UrlType.prod);
    } else {
      urlState.accept(UrlType.dev);
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
      (_) => DebugScreenRoute.showDebugScreenNotification(_pushHandler),
    );

    bind(closeScreenAction, (_) {
      showDebugNotification.accept();
      navigator.pop();
    });

    bind(urlChangeAction, (url) => urlState.accept);

    bind(
        showPerformanceOverlayChangeAction,
        (value) => _setDebugOptionState(
            () => config.debugOptions.copyWith(showPerformanceOverlay: value)));

    bind(
        debugShowMaterialGridChangeAction,
        (value) => _setDebugOptionState(
            () => config.debugOptions.copyWith(debugShowMaterialGrid: value)));

    bind(
        checkerboardRasterCacheImagesChangeAction,
        (value) => _setDebugOptionState(() => config.debugOptions
            .copyWith(checkerboardRasterCacheImages: value)));

    bind(
        checkerboardOffscreenLayersChangeAction,
        (value) => _setDebugOptionState(() =>
            config.debugOptions.copyWith(checkerboardOffscreenLayers: value)));

    bind(
        showSemanticsDebuggerChangeAction,
        (value) => _setDebugOptionState(
            () => config.debugOptions.copyWith(showSemanticsDebugger: value)));

    bind(
        debugShowCheckedModeBannerChangeAction,
        (value) => _setDebugOptionState(() =>
            config.debugOptions.copyWith(debugShowCheckedModeBanner: value)));
  }

  void _refreshApp(Config newConfig) {
    subscribeHandleError(_authInteractor.logOut(), (_) {
      config = newConfig;
      navigator.pushAndRemoveUntil(PhoneInputRoute(), (_) => false);
    });
  }

  void _setDebugOptionState(DebugOptions Function() func) {
    var newOpt = func();
    config = config.copyWith(debugOptions: newOpt);
    debugOptionsState.accept(newOpt);
  }
}
