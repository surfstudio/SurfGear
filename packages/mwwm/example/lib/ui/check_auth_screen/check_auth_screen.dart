import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'check_auth_wm.dart';

/// CheckAuthScreen
class CheckAuthScreen extends CoreMwwmWidget {
  CheckAuthScreen({
    @required WidgetModelBuilder widgetModelBuilder,
  })  : assert(widgetModelBuilder != null),
        super(widgetModelBuilder: widgetModelBuilder);

  @override
  State<StatefulWidget> createState() => _CheckAuthScreenState();
}

class _CheckAuthScreenState extends WidgetState<CheckAuthWm> {
  @override
  Widget build(BuildContext context) => const Scaffold(
        body: SafeArea(
          child: Center(
            child: Text(
              'loading',
              style: TextStyle(
                fontSize: 48,
              ),
            ),
          ),
        ),
      );
}
