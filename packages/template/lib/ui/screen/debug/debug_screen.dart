import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_template/domain/debug_options.dart';
import 'package:flutter_template/interactor/common/urls.dart';
import 'package:flutter_template/ui/res/text_styles.dart';
import 'package:flutter_template/ui/screen/debug/debug_wm.dart';
import 'package:flutter_template/ui/screen/debug/di/debug_screen_component.dart';
import 'package:injector/injector.dart';
import 'package:surf_mwwm/surf_mwwm.dart';

const String testServer = 'Тестовый';
const String prodServer = 'Продуктовый';
const String canSwitch = ' переключить на ';

/// Экран <Debug>
class DebugScreen extends MwwmWidget<DebugScreenComponent> {
  DebugScreen([
    WidgetModelBuilder widgetModelBuilder = createDebugWidgetModel,
  ]) : super(
          dependenciesBuilder: (context) => DebugScreenComponent(context),
          widgetStateBuilder: () => _DebugScreenState(),
          widgetModelBuilder: widgetModelBuilder,
        );
}

class _DebugScreenState extends WidgetState<DebugWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Injector.of<DebugScreenComponent>(context).component.scaffoldKey,
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
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _getPerformanceOverlayCard(),
            _getServerSwitchCard(),
            _getProxyCard(),
          ],
        ),
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
                    _buildSwitchTile(
                      'Включить наложение производительности',
                      state.showPerformanceOverlay,
                      wm.showPerformanceOverlayChangeAction,
                    ),
                    _buildSwitchTile(
                      'Включить наложение базовой сетки',
                      state.debugShowMaterialGrid,
                      wm.debugShowMaterialGridChangeAction,
                    ),
                    _buildSwitchTile(
                      'Показать debug баннер',
                      state.debugShowCheckedModeBanner,
                      wm.debugShowCheckedModeBannerChangeAction,
                    ),
                    _buildSwitchTile(
                      'Включить проверку изображений растрового кэша',
                      state.checkerboardRasterCacheImages,
                      wm.checkerboardRasterCacheImagesChangeAction,
                    ),
                    _buildSwitchTile(
                      'Включает проверку слоев, отображаемых в закадровых растровых изображениях.',
                      state.checkerboardOffscreenLayers,
                      wm.checkerboardOffscreenLayersChangeAction,
                    ),
                    _buildSwitchTile(
                      'Включает наложение, которое показывает информацию о доступности, сообщаемую платформой.',
                      state.showSemanticsDebugger,
                      wm.showSemanticsDebuggerChangeAction,
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

  Widget _getProxyCard() {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text('Прокси-сервер'),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text("Активирует передачу трафика через прокси сервер."),
        ),
        TextFieldStateBuilder(
            state: wm.proxyValueState,
            stateBuilder: (context, proxyUrl) {
              return Column(
                children: <Widget>[
                  TextField(
                    textInputAction: TextInputAction.done,
                    onSubmitted: wm.setProxy,
                    controller: wm.proxyChanges.controller,
                    decoration: InputDecoration(
                        filled: true,
                        border: UnderlineInputBorder(),
                        labelText: 'Адрес прокси сервера',
                        hintText: '192.168.0.1:8888'),
                  ),
                  MaterialButton(
                    onPressed: wm.setProxy,
                    child: Text(
                      'Переключить прокси',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ],
              );
            }),
      ]),
    ));
  }

  Widget _buildSwitchTile(
    String title,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return ListTile(
      title: Text(title),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
