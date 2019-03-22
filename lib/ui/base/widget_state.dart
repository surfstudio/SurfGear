import 'package:flutter/widgets.dart';
import 'package:flutter_template/ui/base/widget_model.dart';

abstract class WidgetState<T extends StatefulWidget, WM extends WidgetModel> extends State<T> {

  @protected
  WM wm;

  @override
  void dispose() {
    wm.dispose();
    super.dispose();
  }
}