import 'package:animations/ui/screen/home/home_screen_wm.dart';
import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';

class HomeScreen extends CoreMwwmWidget {
  const HomeScreen({
    Key? key,
  }) : super(
          key: key,
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
        title: const Text('Ticker provider example'),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: wm.animationController,
          builder: (context, child) => Transform.rotate(
            angle: wm.animation.value,
            child: const FlutterLogo(size: 300),
          ),
        ),
      ),
      floatingActionButton: StreamBuilder<AnimationStatus>(
        stream: wm.status,
        builder: (context, snapshot) {
          return FloatingActionButton(
            onPressed: () {
              wm.shouldPlayAnimation ? wm.startAnimation() : wm.stopAnimation();
            },
            child: Icon(
              wm.shouldPlayAnimation ? Icons.play_arrow : Icons.stop,
            ),
          );
        },
      ),
    );
  }
}
