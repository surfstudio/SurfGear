import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_template/domain/debug_options.dart';
import 'package:flutter_template/interactor/common/urls.dart';
import 'package:flutter_template/ui/app/di/app.dart';
import 'package:flutter_template/ui/res/text_styles.dart';
import 'package:flutter_template/ui/screen/debug/debug_wm.dart';
import 'package:flutter_template/ui/screen/debug/di/debug_screen_component.dart';
import 'package:injector/injector.dart';
import 'package:mwwm/mwwm.dart';

const String testServer = 'Тестовый';
const String prodServer = 'Продуктовый';
const String canSwitch = ' переключить на ';

/// Экран <Debug>
class DebugScreen extends StatefulWidget {
  @override
  _DebugScreenState createState() => _DebugScreenState();
}

class _DebugScreenState
    extends WidgetState<DebugScreen, DebugWidgetModel, DebugScreenComponent> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  DebugScreenComponent getComponent(BuildContext context) {
    return DebugScreenComponent(
      Injector.of<AppComponent>(context).component,
      _scaffoldKey,
      Navigator.of(context),
    );
  }

  @override
  Widget buildState(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          title: Text(
            "Экран отладки",
            style: textMedium20,
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: wm.closeScreenAction,
          )),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          _getPerformanceOverlayCard(),
          _getServerSwitchCard(),
        ],
      ),
    );
  }

  Widget _getServerSwitchCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Text('Сервер'),
            StreamedStateBuilder<UrlType>(
              streamedState: wm.urlState,
              builder: (context, urlState) {
                return Column(
                  children: <Widget>[
                    RadioListTile<UrlType>(
                      groupValue: urlState,
                      title: Text(UrlType.test.toString()),
                      subtitle: Text(Url.testUrl),
                      value: UrlType.test,
                      onChanged: wm.urlChangeAction,
                    ),
                    RadioListTile<UrlType>(
                      groupValue: urlState,
                      title: Text(UrlType.prod.toString()),
                      subtitle: Text(Url.prodUrl),
                      value: UrlType.prod,
                      onChanged: wm.urlChangeAction,
                    ),
                    RadioListTile<UrlType>(
                      groupValue: urlState,
                      title: Text(UrlType.dev.toString()),
                      subtitle: Text(Url.devUrl),
                      value: UrlType.dev,
                      onChanged: wm.urlChangeAction,
                    ),
                    MaterialButton(
                      onPressed: () => wm.switchServer(urlState),
                      child: Text(
                        'Переключить',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _getPerformanceOverlayCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Text('Диагностика'),
            StreamedStateBuilder(
              streamedState: wm.debugOptionsState,
              builder: (context, DebugOptions state) {
                return Column(
                  children: <Widget>[
                    ListTile(
                      title: Text('showPerformanceOverlay'),
                      trailing: Switch(
                        value: state.showPerformanceOverlay,
                        onChanged: wm.showPerformanceOverlayChangeAction,
                      ),
                    ),
                    ListTile(
                      title: Text('debugShowMaterialGrid'),
                      trailing: Switch(
                        value: state.debugShowMaterialGrid,
                        onChanged: wm.debugShowMaterialGridChangeAction,
                      ),
                    ),
                    ListTile(
                      title: Text('debugShowCheckedModeBanner'),
                      trailing: Switch(
                        value: state.debugShowCheckedModeBanner,
                        onChanged: wm.debugShowCheckedModeBannerChangeAction,
                      ),
                    ),
                    ListTile(
                      title: Text('checkerboardRasterCacheImages'),
                      trailing: Switch(
                        value: state.checkerboardRasterCacheImages,
                        onChanged: wm.checkerboardRasterCacheImagesChangeAction,
                      ),
                    ),
                    ListTile(
                      title: Text('checkerboardOffscreenLayers'),
                      trailing: Switch(
                        value: state.checkerboardOffscreenLayers,
                        onChanged: wm.checkerboardOffscreenLayersChangeAction,
                      ),
                    ),
                    ListTile(
                      title: Text('showSemanticsDebugger'),
                      trailing: Switch(
                        value: state.showSemanticsDebugger,
                        onChanged: wm.showSemanticsDebuggerChangeAction,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
