import 'package:flutter/widgets.dart';
import 'package:injector/injector.dart';
import 'package:flutter_template/ui/base/widget_model.dart';

abstract class WidgetState<T extends StatefulWidget, WM extends WidgetModel,
        C extends Component> extends State<T>
    with AutomaticKeepAliveClientMixin<T> {
  @protected
  WM wm;

  C _component;

  @override
  bool get wantKeepAlive => true;

  Widget buildState(BuildContext context);

  C getComponent(BuildContext context);

  @override
  void initState() {
    super.initState();
    print("DEV_INFO init State $this");
    _component = getComponent(context);
  }

  @override
  Widget build(BuildContext context) {
    print("DEV_INFO $this rebuild");
    return Injector(
      component: _component,
      builder: (context) {
        _attachWidgetModel(context);
        return buildState(context);
      },
    );
  }

  void _attachWidgetModel(BuildContext context) {
    var _debug_wm = Injector.of<C>(context).get(WM);
    print("DEV_INFO identical wm ${wm == _debug_wm}");
    wm ??= _debug_wm;
  }

  @override
  void dispose() {
    wm.dispose();
    super.dispose();
  }
}
