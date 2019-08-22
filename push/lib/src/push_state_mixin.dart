import 'package:flutter/widgets.dart';
import 'package:push/push.dart';

mixin PushStateMixin<T extends StatefulWidget> on State<T> {
  void didChangeDependencies() {
    super.didChangeDependencies();
    PushContextHolder().context = context;
  }
}
