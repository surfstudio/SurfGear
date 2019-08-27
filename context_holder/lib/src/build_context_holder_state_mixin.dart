import 'package:context_holder/context_holder.dart';
import 'package:flutter/widgets.dart';

/// Getting context by mixing into a widget
mixin BuildContextHolderStateMixin<T extends StatefulWidget> on State<T> {
  void didChangeDependencies() {
    super.didChangeDependencies();
    BuildContextHolder.instance.context = context;
  }
}
