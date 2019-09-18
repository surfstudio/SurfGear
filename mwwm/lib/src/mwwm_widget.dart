import 'package:flutter/widgets.dart';
import 'package:injector/injector.dart';
import 'package:mwwm/src/widget_model.dart';

typedef WidgetModelBuilder<C> = WidgetModel Function(BuildContext, C);

class MWWMWidget<C extends Component> extends StatefulWidget {
  final C component;
  final WidgetModelBuilder<C> wmBuilder;
  final Widget child;

  const MWWMWidget({
    Key key,
    this.component,
    this.wmBuilder,
    this.child,
  }) : super(key: key);

  @override
  _MWWMWidgetState createState() => _MWWMWidgetState();
}

class _MWWMWidgetState extends State<MWWMWidget> {

  @override
  Widget build(BuildContext context) {
    return Injector(
      component: widget.component,
      builder: (context) {
          return widget.child;
      },
    );
  }
}
