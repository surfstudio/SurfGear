import 'package:example2/ui/users_screen/user_screen_wm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserScreenRoute<T> extends MaterialPageRoute<T> {
  UserScreenRoute() : super(builder: (ctx) => const UserScreen());
}

UserScreenWidgetModel _createUserWM(BuildContext context) {
  return context.read<UserScreenWidgetModel>();
}
