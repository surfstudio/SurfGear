import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';

class HomeScreenWidgetModel extends WidgetModel
    with TickerProviderWidgetModelMixin {
  HomeScreenWidgetModel(
    WidgetModelDependencies baseDependencies,
  ) : super(baseDependencies);

  AnimationController animationController;
  Animation animation;

  final _statusController = StreamController<AnimationStatus>();

  Stream<AnimationStatus> get status => _statusController.stream;

  void startAnimation() => animationController.repeat();

  void stopAnimation() => animationController.reset();

  @override
  void onLoad() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    animation = Tween(begin: 0.0, end: 2 * math.pi).animate(
      animationController,
    );

    animationController.addStatusListener((status) {
      _statusController.add(status);
    });
    super.onLoad();
  }

  @override
  void dispose() {
    _statusController.close();
    animationController.dispose();
    super.dispose();
  }
}

HomeScreenWidgetModel createHomeScreenWm(BuildContext context) =>
    HomeScreenWidgetModel(
      WidgetModelDependencies(),
    );
