import 'package:flutter/widgets.dart';
import 'package:injector/injector.dart';
import 'package:mwwm/mwwm.dart';
import 'package:mwwm/mwwm.dart' as mwwm;

typedef DependenciesBuilder<C> = C Function(BuildContext);

/// Base class for widgets that has [WidgetModel]
/// and has dependencies in [Component]
abstract class SurfMwwmWidget<C extends Component> extends StatefulWidget {
  /// A function that build dependencies for WidgetModel and Widget
  final DependenciesBuilder<C> dependenciesBuilder;

  /// Builder for [WidgetState]
  final WidgetStateBuilder widgetStateBuilder;

  /// Builder for [WidgetModel].
  /// Typically is null because
  /// WidgetModelBuilders set in the [WidgetModelFactory]
  final WidgetModelBuilder widgetModelBuilder;

  SurfMwwmWidget({
    Key key,
    @required this.dependenciesBuilder,
    @required this.widgetStateBuilder,
    this.widgetModelBuilder,
  }) : super(
          key: key,
        );

  @override
  _SurfMwwmWidgetState createState() => _SurfMwwmWidgetState<C>();
}

/// Hidden widget that create [WidgetState]
/// It's only proxy builder for [State]
class _ProxyMwwmWidget extends mwwm.MwwmWidget {
  const _ProxyMwwmWidget({
    Key key,
    WidgetStateBuilder widgetStateBuilder,
    WidgetModelBuilder widgetModelBuilder,
  }) : super(
          key: key,
          widgetStateBuilder: widgetStateBuilder,
          widgetModelBuilder: widgetModelBuilder,
        );
}

/// Hold child widget
class _SurfMwwmWidgetState<C extends Component> extends State<SurfMwwmWidget> {
  Widget child;

  @override
  void initState() {
    super.initState();

    child = Injector<C>(
      component: widget.dependenciesBuilder(context),
      builder: (ctx) => _ProxyMwwmWidget(
        widgetStateBuilder: widget.widgetStateBuilder,
        widgetModelBuilder: widget.widgetModelBuilder,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return child;
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
                return _ProxyMwwmWidget(
                  widgetStateBuilder: widgetStateBuilder,
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
