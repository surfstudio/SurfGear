import 'package:flutter/widgets.dart';
import 'package:injector/injector.dart';
import 'package:mwwm/mwwm.dart';
import 'package:mwwm/src/widget_model_creator.dart';

typedef WidgetStateBuilder = State Function();

/// Base class for widgets that has [WidgetModel]
abstract class MwwmWidget<C extends Component, WM extends WidgetModel>
    extends StatefulWidget {
  /// Do not override this
  @override
  State<StatefulWidget> createState() => _MwwWidgetState<C>(buildState);

  /// Common method for create state for Widget
  /// It is alias for [StatefulWidget.createState]
  @protected
  State buildState();

  /// Methods that creates [Component].
  /// Common patter is provide only context in [Component]
  @protected
  C createComponent(BuildContext context);
}

/// Base class for state of [MwwmWidget].
/// Has [WidgetModel] from [initState].
abstract class WidgetState<WM extends WidgetModel> extends State<_Proxy> {
  final WidgetModelCreator _wmc = WidgetModelCreator<WM>();

  /// [WidgetModel] for widget.
  @protected
  WM wm;

  /// Descedants must call super firstly
  @mustCallSuper
  @override
  void initState() {
    _wmc.initWm(context);
    wm = _wmc.wm;
    super.initState();
  }

  /// Descedants must call super in the end
  @protected
  @mustCallSuper
  void dispose() {
    wm.dispose();
    super.dispose();
  }
}

// hidden zone
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
