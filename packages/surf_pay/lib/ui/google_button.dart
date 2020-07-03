import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:surfpay/ui/assets/google_pay_grey.dart';
import 'package:surfpay/ui/assets/google_pay_white.dart';

const _cornerRadius = 4.0;
const _backgroundColorWhite = Color(0xFFFFFFFF);
const _backGroundColorBlack = Color(0xFF000000);

class GoogleButton extends StatelessWidget {
  final VoidCallback onTap;
  final double height;
  final double width;
  final ButtonStyle style;

  GoogleButton({
    this.onTap,
    this.height = 48,
    this.width = 158,
    this.style = ButtonStyle.black,
  });

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
            child: SvgPicture.string(_getLogo()),
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
      case ButtonStyle.black:
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
      case ButtonStyle.black:
      case ButtonStyle.whiteWithBorder:
      default:
        return 0.0;
    }
  }

  String _getLogo() {
    switch (style) {
      case ButtonStyle.black:
        return googlePayWhite;
      case ButtonStyle.white:
      case ButtonStyle.whiteWithBorder:
      default:
        return googlePayGrey;
    }
  }
}

enum ButtonStyle {
  black,
  white,
  whiteWithBorder,
}
