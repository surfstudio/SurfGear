import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';

class HomeScreenWidgetModel extends WidgetModel
    with TickerProviderWidgetModelMixin {
  HomeScreenWidgetModel(
    WidgetModelDependencies baseDependencies,
  ) : super(baseDependencies);

  late AnimationController animationController;
  late Animation<double> animation;

  final _statusController = StreamController<AnimationStatus>();

  Stream<AnimationStatus> get status => _statusController.stream;

  void startAnimation() => animationController.repeat();

  void stopAnimation() => animationController.reset();

  bool get shouldPlayAnimation =>
      animationController.status == AnimationStatus.completed ||
      animationController.status == AnimationStatus.dismissed;

  @override
  void onLoad() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    animation = Tween(begin: 0.0, end: 2 * math.pi).animate(
      animationController,
    );

    animationController.addStatusListener(_statusController.add);
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
      const WidgetModelDependencies(),
    );
