import 'package:flutter/material.dart';
import 'package:name_generator/interactor/name_generator/name_generator_interactor.dart';
import 'package:name_generator/ui/screen/name_generator/name_generator_screen.dart';

/// Route для экрана
class NameGeneratorScreenRoute extends MaterialPageRoute {
  NameGeneratorScreenRoute(NameGeneratorInteractor interactor)
      : super(builder: (ctx) => NameGeneratorScreen(interactor));
}
