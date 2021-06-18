import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';

class PickNameScreenWidgetModel extends WidgetModel {
  PickNameScreenWidgetModel(
    WidgetModelDependencies baseDependencies,
  ) : super(baseDependencies);

  final TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }
}
