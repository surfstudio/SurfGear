import 'package:flutter/material.dart';

mixin CustomSnackBarOwner {
  Map<dynamic, SnackBar Function(String)> get registeredSnackBarsBuilder;
}
