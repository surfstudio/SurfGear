import 'package:flutter/widgets.dart';
import 'package:injector/injector.dart';
import 'package:mwwm/mwwm.dart';
import 'package:mwwm/src/mixins/lifecycle_logging_mixin.dart';
import 'package:mwwm/src/widget_model_creator.dart';

typedef WidgetStateBuilder = State Function();
typedef DependenciesBuilder<C> = C Function(BuildContext);

/// Base class for widgets that has [WidgetModel]
abstract class MwwmWidget<C extends Component> extends StatefulWidget {
  /// A function that build dependencies for WidgetModel and Widget
  final DependenciesBuilder<C> dependenciesBuilder;

  /// Builder for [WidgetState]
  final WidgetStateBuilder widgetStateBuilder;

  /// Builder for [WidgetModel].
  /// Typically is null because
  /// WidgetModelBuilders set in the [WidgetModelFactory]
  final WidgetModelBuilder widgetModelBuilder;

  MwwmWidget({
    Key key,
    @required this.dependenciesBuilder,
    @required this.widgetStateBuilder,
    this.widgetModelBuilder,
  }) : super(
          key: key,
        );

  @override
  _MwwmWidgetState createState() => _MwwmWidgetState<C>();
}

/// Hold child widget
class _MwwmWidgetState<C extends Component> extends State<MwwmWidget> {
  Widget child;

  @override
  void initState() {
    super.initState();

    child = Injector<C>(
      component: widget.dependenciesBuilder(context),
      builder: (ctx) => _MwwmWidget(
        wsBuilder: widget.widgetStateBuilder,
        widgetModelBuilder: widget.widgetModelBuilder,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

/// Hidden widget that create [WidgetState]
/// It's only proxy builder for [State]
class _MwwmWidget extends StatefulWidget {
  final WidgetStateBuilder wsBuilder;
  final WidgetModelBuilder widgetModelBuilder;

  const _MwwmWidget({Key key, this.wsBuilder, this.widgetModelBuilder})
      : super(key: key);

  @override
  State createState() {
    return wsBuilder();
  }
}

/// Base class for state of [MwwmWidget].
/// Has [WidgetModel] from [initState].
abstract class WidgetState<WM extends WidgetModel> extends State<_MwwmWidget>
    with LifecycleLoggingMixin<_MwwmWidget> {
  final WidgetModelCreator _wmc = WidgetModelCreator<WM>();

  /// [WidgetModel] for widget.
  @protected
  WM wm;

  /// Descedants must call super firstly
  @mustCallSuper
  @override
  void initState() {
    var wmbBuilder = widget.widgetModelBuilder;
    if (wmbBuilder == null) {
      _wmc.initWm(context);
      wm = _wmc.wm;
    } else {
      wm = wmbBuilder(context);
    }
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

/// Implementation of MwwmWidget based on [InheritedWidget]
/// todo test perfomance
abstract class MwwmInheritedWidget<C extends Component>
    extends InheritedWidget {
  MwwmInheritedWidget({
    @required DependenciesBuilder<C> dependenciesBuilder,
    @required WidgetStateBuilder widgetStateBuilder,
    WidgetModelBuilder widgetModelBuilder,
  }) : super(
          child: Builder(
            builder: (context) => Injector<C>(
              component: dependenciesBuilder(context),
              builder: (ctx) {
                return _MwwmWidget(
                  wsBuilder: widgetStateBuilder,
                  widgetModelBuilder: widgetModelBuilder,
                );
              },
            ),
          ),
        );

  /// Yet this forever true because otherwise hot reload not working.
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}
