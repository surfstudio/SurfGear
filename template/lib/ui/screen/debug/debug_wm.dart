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
  final performanceOverlayState = StreamedState<bool>(
      Environment.instance().config.debugOptions.showPerformanceOverlay);

  final switchServer = Action<UrlType>();
  final showDebugNotification = Action();

  String currentUrl;

  @override
  void onLoad() {
    super.onLoad();

    currentUrl = Environment.instance().config.url;
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
          newConfig = Config(
            url: Url.testUrl,
            debugOptions: Environment.instance().config.debugOptions,
          );
          break;
        case UrlType.prod:
          newConfig = Config(
            url: Url.prodUrl,
            debugOptions: Environment.instance().config.debugOptions,
          );
          break;
        default:
          newConfig = Config(
            url: Url.devUrl,
            debugOptions: Environment.instance().config.debugOptions,
          );
          break;
      }
      _refreshApp(newConfig);
    });

    subscribe(performanceOverlayState.stream, (value) {
      var newConfig = Config(
        url: Environment.instance().config.url,
        debugOptions: DebugOptions(
          showPerformanceOverlay: value,
        ),
      );
      Environment.instance().config = newConfig;
    });

    bind(
      showDebugNotification,
      (_) => DebugScreenRoute.showDebugScreenNotification(_pushHandler),
    );
  }

  void _refreshApp(Config newConfig) {
    subscribeHandleError(_authInteractor.logOut(), (_) {
      Environment.instance().config = newConfig;
      navigator.pushAndRemoveUntil(PhoneInputRoute(), (_) => false);
    });
  }
}
