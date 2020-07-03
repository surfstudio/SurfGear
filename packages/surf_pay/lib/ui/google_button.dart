import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:surfpay/ui/assets/google_pay/buy_with_white.dart';
import 'package:surfpay/ui/assets/google_pay/google_pay_grey.dart';
import 'package:surfpay/ui/assets/google_pay/google_pay_white.dart';

import 'assets/google_pay/buy_with_grey.dart';

const _cornerRadius = 4.0;
const _backgroundColorWhite = Color(0xFFFFFFFF);
const _backGroundColorBlack = Color(0xFF000000);

class GoogleButton extends StatelessWidget {
  final VoidCallback onTap;
  final double height;
  final double width;
  final logoHeight;
  final ButtonStyle style;
  final bool withPrefix;

  GoogleButton({
    this.onTap,
    this.height = 48.0,
    this.logoHeight = 17.0,
    this.style = ButtonStyle.dark,
    this.withPrefix = false,
    double width,
  }) : width = width ?? withPrefix ? 152.0 : 90.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: _getBackgroundColor(),
        borderRadius: BorderRadius.circular(_cornerRadius),
        elevation: _getElevation(),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(_cornerRadius),
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_cornerRadius),
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
    return style != ButtonStyle.whiteWithBorder
        ? null
        : Border.all(
            width: 1,
            color: Colors.grey[300],
          );
  }

  Color _getBackgroundColor() {
    switch (style) {
      case ButtonStyle.dark:
        return _backGroundColorBlack;
      case ButtonStyle.white:
      case ButtonStyle.whiteWithBorder:
      default:
        return _backgroundColorWhite;
    }
  }

  double _getElevation() {
    switch (style) {
      case ButtonStyle.white:
        return 2.0;
      case ButtonStyle.dark:
      case ButtonStyle.whiteWithBorder:
      default:
        return 0.0;
    }
  }

  String _getLogo() {
    switch (style) {
      case ButtonStyle.dark:
        return withPrefix ? googleBuyWithWhite : googlePayWhite;
      case ButtonStyle.white:
      case ButtonStyle.whiteWithBorder:
      default:
        return withPrefix ? googleBuyWithGrey : googlePayGrey;
    }
  }
}

enum ButtonStyle {
  dark,
  white,
  whiteWithBorder,
}
