import 'package:example2/ui/users_screen/user_screen.dart';
import 'package:example2/ui/users_screen/user_screen_wm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserScreenRoute<T> extends MaterialPageRoute<T> {
  UserScreenRoute()
      : super(
          builder: (ctx) => const UserScreen(
            widgetModelBuilder: _createUserWM,
          ),
        );
}

UserScreenWidgetModel _createUserWM(BuildContext context) {
  return context.read<UserScreenWidgetModel>();
}
