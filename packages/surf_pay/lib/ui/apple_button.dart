import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:surfpay/ui/assets/apple_pay/apple_buy_with_dark.dart';
import 'package:surfpay/ui/assets/apple_pay/apple_buy_with_white.dart';
import 'package:surfpay/ui/assets/apple_pay/apple_pay_dark.dart';
import 'package:surfpay/ui/assets/apple_pay/apple_pay_white.dart';

const _backgroundColorWhite = Color(0xFFFFFFFF);
const _backGroundColorBlack = Color(0xFF000000);

/// https://developer.apple.com/design/human-interface-guidelines/apple-pay/overview/buttons-and-marks/#apple-pay-mark
class AppleButton extends StatelessWidget {
  final double radius;
  final VoidCallback onTap;
  final double height;
  final double width;
  final logoHeight;
  final IOSButtonStyle style;
  final bool withPrefix;

  AppleButton({
    this.onTap,
    this.height = 48.0,
    this.logoHeight = 17.0,
    this.style = IOSButtonStyle.white,
    this.withPrefix = false,
    this.radius = 4.0,
    double width,
  }) : width = width ?? withPrefix ? 152.0 : 90.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: _getBackgroundColor(),
        borderRadius: BorderRadius.circular(radius),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(radius),
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              border: _buildBorder(),
            ),
            child: SvgPicture.string(
              _getLogo(),
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
      ),
    );
  }

  BoxBorder _buildBorder() {
    return style != IOSButtonStyle.white
        ? null
        : Border.all(
            width: 1,
            color: Colors.black,
          );
  }

  Color _getBackgroundColor() {
    switch (style) {
      case IOSButtonStyle.dark:
        return _backGroundColorBlack;
      case IOSButtonStyle.white:
      default:
        return _backgroundColorWhite;
    }
  }

  double _getElevation() {
    switch (style) {
      case IOSButtonStyle.white:
        return 2.0;
      case IOSButtonStyle.dark:
      default:
        return 0.0;
    }
  }

  String _getLogo() {
    switch (style) {
      case IOSButtonStyle.dark:
        return withPrefix ? appleBuyWithWhite : applePayWhite;
      case IOSButtonStyle.white:
      default:
        return withPrefix ? appleBuyWithDark : applePayDark;
    }
  }
}

enum IOSButtonStyle {
  dark,
  white,
}
