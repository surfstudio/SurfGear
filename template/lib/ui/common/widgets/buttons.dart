

import 'package:flutter/material.dart';
import 'package:flutter_template/ui/res/colors.dart';

/// Кнопка с лоадером
class LoadableButton extends StatelessWidget {
  const LoadableButton({
    Key key,
    this.isLoading = false,
    this.action,
    this.progressIndicator,
    this.backgroundColor,
    this.splashColor,
    this.enabled = true,
    this.child,
  }) : super(key: key);

  final Function action;

  final bool enabled;
  final bool isLoading;
  final Widget progressIndicator;
  final Color backgroundColor, splashColor;
  final Widget child;

  _buildButtonChild() {
    if (isLoading ?? false) {
      return Transform.scale(
        scale: 0.5,
        child: progressIndicator ??
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
      );
    } else {
      return child;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      onPressed: !(enabled ?? false) || (isLoading ?? false) ? null : action,
      child: _buildButtonChild(),
      splashColor: splashColor ?? Colors.redAccent[100],
      color: backgroundColor ?? btnColor,
      disabledColor: dividerColor,
      disabledTextColor: textColorSecondaryDark,
    );
  }
}

/// FAB с Opacity при дизейбле
class OpacityFab extends StatelessWidget {
  const OpacityFab({
    Key key,
    @required this.onPressed,
    this.enabled = true,
  }) : super(key: key);

  final Function onPressed;
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
