
import 'package:flutter/widgets.dart';
import 'package:mwwm/src/widget_model.dart';
import 'package:mwwm/src/wm_factory.dart';

///A simple widget model creator.
class WidgetModelCreator<WM extends WidgetModel> {
  WM wm;

  void initWm(BuildContext context) {
    wm = WidgetModelFactory.instance().by<WM>(context);
  }
}