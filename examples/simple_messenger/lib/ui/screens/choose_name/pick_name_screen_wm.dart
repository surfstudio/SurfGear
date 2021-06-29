import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';

class PickNameScreenWidgetModel extends WidgetModel {
  final TextEditingController nameController = TextEditingController();

  PickNameScreenWidgetModel(
    WidgetModelDependencies baseDependencies,
  ) : super(baseDependencies);

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }
}
