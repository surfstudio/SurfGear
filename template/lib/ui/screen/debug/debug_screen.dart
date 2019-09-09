import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
    return _buildScreen(context);
  }

  Widget _buildScreen(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          title: Text(
            "Экран отладки",
            style: textMedium20,
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              wm.showDebugNotification.accept();
              Navigator.of(context).pop();
            },
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
                      onChanged: wm.urlState.accept,
                    ),
                    RadioListTile<UrlType>(
                      groupValue: urlState,
                      title: Text(UrlType.prod.toString()),
                      subtitle: Text(Url.prodUrl),
                      value: UrlType.prod,
                      onChanged: wm.urlState.accept,
                    ),
                    RadioListTile<UrlType>(
                      groupValue: urlState,
                      title: Text(UrlType.dev.toString()),
                      subtitle: Text(Url.devUrl),
                      value: UrlType.dev,
                      onChanged: wm.urlState.accept,
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
              streamedState: wm.performanceOverlayState,
              builder: (context, state) {
                return Row(
                  children: <Widget>[
                    Expanded(
                      child: Text('Диаграмма производительности'),
                    ),
                    Switch(
                      value: state,
                      onChanged: wm.performanceOverlayState.accept,
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
