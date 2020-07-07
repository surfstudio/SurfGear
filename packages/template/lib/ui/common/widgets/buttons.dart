import 'package:flutter/material.dart';
import 'package:flutter_template/ui/res/colors.dart';

/// FAB с Opacity при дизейбле
class OpacityFab extends StatelessWidget {
  const OpacityFab({
    @required this.onPressed,
    Key key,
    this.enabled = true,
  })  : assert(onPressed != null),
        super(key: key);

  final VoidCallback onPressed;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1.0 : .4,
      child: Container(
        width: 40,
        height: 40,
        child: FloatingActionButton(
          onPressed: enabled ? onPressed : null,
          disabledElevation: 0.0,
          child: Icon(
            Icons.arrow_forward,
            color: white,
          ),
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
    );
  }
}
