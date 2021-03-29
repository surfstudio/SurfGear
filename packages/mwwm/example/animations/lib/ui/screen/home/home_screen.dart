import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mwwm/mwwm.dart';

import 'home_screen_wm.dart';

class HomeScreen extends CoreMwwmWidget {
  HomeScreen({
    WidgetModelBuilder widgetModelBuilder = createHomeScreenWm,
  }) : super(
          widgetModelBuilder: createHomeScreenWm,
        );

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends WidgetState<HomeScreenWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ticker provider example"),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: wm.animationController,
          builder: (context, child) => Transform.rotate(
            angle: wm.animation.value,
            child: FlutterLogo(size: 300),
          ),
        ),
      ),
      floatingActionButton: StreamBuilder<AnimationStatus>(
        stream: wm.status,
        builder: (context, snapshot) {
          return FloatingActionButton(
            child: Icon(
              wm.shouldPlayAnimation ? Icons.play_arrow : Icons.stop,
            ),
            onPressed: () {
              wm.shouldPlayAnimation ? wm.startAnimation() : wm.stopAnimation();
            },
          );
        },
      ),
    );
  }
}
