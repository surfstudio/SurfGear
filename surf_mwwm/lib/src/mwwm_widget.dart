import 'package:flutter/widgets.dart';
import 'package:injector/injector.dart';
import 'package:mwwm/mwwm.dart';

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
      builder: (ctx) => ProxyMwwmWidget(
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
                return ProxyMwwmWidget(
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
