import 'package:auto_reload/auto_reload.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Demo widget for [AutoReloadMixin]
class DemoAutoReloadWidget extends StatefulWidget {
  const DemoAutoReloadWidget({Key key}) : super(key: key);
  @override
  _DemoAutoReloadWidgetState createState() => _DemoAutoReloadWidgetState();
}

abstract class _AutoReloadState extends State<DemoAutoReloadWidget>
    implements AutoReloader {}

class _DemoAutoReloadWidgetState extends _AutoReloadState with AutoReloadMixin {
  @override
  // ignore: overridden_fields
  final Duration autoReloadDuration = const Duration(seconds: 3);

  int _countOfReload = 0;

  @override
  void initState() {
    super.initState();
    startAutoReload();
  }

  @override
  void dispose() {
    cancelAutoReload();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Spacer(),
        Text(
          'auto reload example:',
          style: TextStyle(
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text('count of reload $_countOfReload'),
        const Spacer(),
      ],
    );
  }

  @override
  void autoReload() {
    setState(() {
      _countOfReload = _countOfReload + 1;
    });
  }
}
