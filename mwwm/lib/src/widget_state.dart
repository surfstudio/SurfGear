import 'package:flutter/widgets.dart';
import 'package:injector/injector.dart';
import 'package:mwwm/src/di/base_wm_component.dart';
import 'package:mwwm/src/holder/global_context_holder.dart';
import 'package:mwwm/src/widget_model.dart';

abstract class WidgetState<T extends StatefulWidget, WM extends WidgetModel,
        C extends BaseWidgetModelComponent<WM>> extends State<T>
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
    super.build(context); //need for AutomaticKeepAliveClientMixin
    print("DEV_INFO $this rebuild");
    return Injector(
      component: _component,
      builder: (context) {
        _attachWidgetModel(context);
        GlobalContextHolder().context = context;
        return buildState(context);
      },
    );
  }

  void _attachWidgetModel(BuildContext context) {
    var _debug_wm = Injector.of<C>(context).component.wm;
    print("DEV_INFO identical wm ${wm == _debug_wm}");
    wm ??= _debug_wm;
  }

  @override
  void dispose() {
    wm.dispose();
    super.dispose();
  }
}
