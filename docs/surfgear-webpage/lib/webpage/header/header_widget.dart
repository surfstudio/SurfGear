import 'dart:math' show max;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:surfgear_webpage/assets/images.dart';
import 'package:surfgear_webpage/components/menu.dart';
import 'package:surfgear_webpage/webpage/webpage_widget.dart';

class HeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        DecoratedBox(
          position: DecorationPosition.foreground,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 0.35, 1.0],
              colors: [
                Color(0x050E16).withOpacity(0.81),
                Color(0x0F263C).withOpacity(0.36),
                Colors.transparent,
              ],
            ),
          ),
          child: OverflowBox(
            minWidth: max(MediaQuery.of(context).size.width, 1920),
            maxWidth: double.infinity,
            child: Image.asset(
              imgBackground,
              fit: BoxFit.fitWidth,
              alignment: Alignment(0.0, -0.3),
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ),
        _LogoAndText(),
        Align(
          alignment: Alignment.topCenter,
          child: Theme(
            data: Theme.of(context).copyWith(brightness: Brightness.dark),
            child: Menu(),
          ),
        ),
      ],
    );
  }
}

class _LogoAndText extends StatefulWidget {
  @override
  __LogoAndTextState createState() => __LogoAndTextState();
}

class __LogoAndTextState extends State<_LogoAndText> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    if (!_visible) {
      Future.delayed(const Duration(milliseconds: 1000),
          () => setState(() => _visible = true));
    }

    final children = <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 56.0,
          vertical: 32.0,
        ),
        child: AnimatedOpacity(
          opacity: _visible ? 1 : 0,
          duration: const Duration(milliseconds: 350),
          child: Image.asset(imgLogo),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 56.0,
          vertical: 32.0,
        ),
        child: AnimatedOpacity(
          opacity: _visible ? 1 : 0,
          duration: const Duration(milliseconds: 350),
          child: AutoSizeText(
            'Плагины для Flutter-проектов',
            textAlign: TextAlign.center,
            maxLines: 2,
            style: GoogleFonts.rubik(
              color: Colors.white,
              fontSize: 42.0,
            ),
          ),
        ),
      ),
    ];

    if (MediaQuery.of(context).size.width > MEDIUM_SCREEN_WIDTH) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      );
    }
  }
}
