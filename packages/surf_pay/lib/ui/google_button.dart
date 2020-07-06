import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:surfpay/ui/assets/google_pay/google_buy_with_grey.dart';
import 'package:surfpay/ui/assets/google_pay/google_pay_grey.dart';
import 'package:surfpay/ui/assets/google_pay/google_pay_white.dart';
import 'package:surfpay/ui/assets/google_pay/google_with_white.dart';

const _backgroundColorWhite = Color(0xFFFFFFFF);
const _backGroundColorBlack = Color(0xFF000000);

/// https://developers.google.com/pay/api/android/guides/brand-guidelines?hl=en
class GoogleButton extends StatelessWidget {
  final double radius;
  final VoidCallback onTap;
  final double height;
  final double width;
  final logoHeight;
  final AndroidButtonStyle style;
  final bool withPrefix;

  GoogleButton({
    this.onTap,
    this.height = 48.0,
    this.logoHeight = 17.0,
    this.style = AndroidButtonStyle.dark,
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
        elevation: _getElevation(),
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
    return style != AndroidButtonStyle.whiteWithBorder
        ? null
        : Border.all(
            width: 1,
            color: Colors.grey[300],
          );
  }

  Color _getBackgroundColor() {
    switch (style) {
      case AndroidButtonStyle.dark:
        return _backGroundColorBlack;
      case AndroidButtonStyle.white:
      case AndroidButtonStyle.whiteWithBorder:
      default:
        return _backgroundColorWhite;
    }
  }

  double _getElevation() {
    switch (style) {
      case AndroidButtonStyle.white:
        return 2.0;
      case AndroidButtonStyle.dark:
      case AndroidButtonStyle.whiteWithBorder:
      default:
        return 0.0;
    }
  }

  String _getLogo() {
    switch (style) {
      case AndroidButtonStyle.dark:
        return withPrefix ? googleBuyWithWhite : googlePayWhite;
      case AndroidButtonStyle.white:
      case AndroidButtonStyle.whiteWithBorder:
      default:
        return withPrefix ? googleBuyWithGrey : googlePayGrey;
    }
  }
}

enum AndroidButtonStyle {
  dark,
  white,
  whiteWithBorder,
}
