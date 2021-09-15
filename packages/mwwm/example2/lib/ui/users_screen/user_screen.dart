import 'package:example2/ui/users_screen/user_screen_wm.dart';
import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:provider/provider.dart';

class UserScreen extends CoreMwwmWidget<UserScreenWidgetModel> {
  const UserScreen(
      {required WidgetModelBuilder<UserScreenWidgetModel> widgetModelBuilder,
      Key? key})
      : super(widgetModelBuilder: widgetModelBuilder, key: key);

  @override
  WidgetState<CoreMwwmWidget<UserScreenWidgetModel>, UserScreenWidgetModel>
      createWidgetState() {
    return _UserScreenState();
  }
}

class _UserScreenState extends WidgetState<UserScreen, UserScreenWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<UserScreenWidgetModel>(builder: (_, wm, __) {
          return Text("dd");
        }),
      ),
    );
  }
}
