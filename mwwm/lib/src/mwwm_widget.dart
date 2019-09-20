import 'package:flutter/widgets.dart';
import 'package:injector/injector.dart';
import 'package:mwwm/mwwm.dart';
import 'package:mwwm/src/widget_model_creator.dart';

typedef WidgetStateBuilder = State Function();

abstract class MwwmWidget<C extends Component, WM extends WidgetModel>
    extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MwwWidgetState<C>(buildState);

  @protected
  State buildState();

  @protected
  C createComponent(BuildContext context);
}

abstract class WidgetState<WM extends WidgetModel>
    extends State<_Proxy> {
  final WidgetModelCreator _wmc = WidgetModelCreator<WM>();

  @protected
  WM wm;

  @override
  void initState() {
    _wmc.initWm(context);
    wm = _wmc.wm;
    super.initState();
  }

  @protected
  Widget build(BuildContext context);

  @protected
  @mustCallSuper
  void dispose() {
    wm.dispose();
    super.dispose();
  }
}

class _MwwWidgetState<C extends Component> extends State<MwwmWidget> {
  final WidgetStateBuilder ws;

  _MwwWidgetState(this.ws);

  @override
  Widget build(BuildContext context) {
    return Injector<C>(
      component: widget.createComponent(context),
      builder: (ctx) {
        return _Proxy(
          wsBuilder: ws,
        );
      },
    );
  }
}

class _Proxy extends StatefulWidget {
  final WidgetStateBuilder wsBuilder;

  const _Proxy({Key key, this.wsBuilder}) : super(key: key);

  @override
  WidgetState createState() => wsBuilder();
}
