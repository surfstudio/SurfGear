import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:surfpay/ui/assets/apple_pay/apple_buy_with_dark.dart';
import 'package:surfpay/ui/assets/apple_pay/apple_buy_with_white.dart';
import 'package:surfpay/ui/assets/apple_pay/apple_pay_dark.dart';
import 'package:surfpay/ui/assets/apple_pay/apple_pay_white.dart';

const _backgroundColorWhite = Color(0xFFFFFFFF);
const _backGroundColorBlack = Color(0xFF000000);

/// Button for Apple Pay
/// https://developer.apple.com/design/human-interface-guidelines/apple-pay/overview/buttons-and-marks/#apple-pay-mark
class AppleButton extends StatelessWidget {
  const AppleButton({
    Key key,
    this.onTap,
    this.height = 48.0,
    this.logoHeight = 17.0,
    this.style = IOSButtonStyle.white,
    this.radius = 4.0,
    this.withPrefix = false,
    double width,
  })  : width = width ?? (withPrefix ? 152.0 : 90.0),
        super(key: key);

  /// Corner radius
  final double radius;

  /// On tap callback
  final VoidCallback onTap;

  /// Button height
  final double height;

  /// Button width
  final double width;

  /// Button's logo height
  final double logoHeight;

  /// Button style
  final IOSButtonStyle style;

  /// If need 'Buy with' prefix
  final bool withPrefix;

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

/// Apple pay button style
enum IOSButtonStyle {
  dark,
  white,
}
