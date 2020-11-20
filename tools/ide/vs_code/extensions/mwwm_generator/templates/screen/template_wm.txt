import 'package:flutter/widgets.dart';
import 'package:mwwm/mwwm.dart';

/// [Wm] для Template
class TemplateWm extends Wm {
  TemplateWm(
    WmDependencies dependencies,
    this.navigator,
  ) : super(dependencies);

  final NavigatorState navigator;

  @override
  void onLoad() {
    super.onLoad();
    //TODO
  }
}
