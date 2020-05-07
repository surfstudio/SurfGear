import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:surfgear_webpage/assets/text_styles.dart';
import 'package:surfgear_webpage/pages/main/main_page.dart';

/// Feature item
class FeatureItem extends StatefulWidget {
  /// Image path
  final String imagePath;

  /// Feature title
  final String title;

  /// Feature description
  final String description;

  /// Feature image direction
  final bool isRightSide;

  /// Animation delay
  final Duration delay;

  /// Stream in which the animation start event is stored
  final StreamController<bool> controller;

  /// Image offset
  final Offset imageOffset;

  FeatureItem({
    @required this.imagePath,
    @required this.title,
    @required this.description,
    @required this.delay,
    this.isRightSide = false,
    this.imageOffset = const Offset(0, 0),
    this.controller,
  });

  @override
  State<StatefulWidget> createState() {
    return _FeatureItem();
  }
}

class _FeatureItem extends State<FeatureItem>
    with SingleTickerProviderStateMixin {
  /// Begin animation
  static bool _startAnimation = false;

  @override
  void initState() {
    super.initState();
    _listenStartAnimation();
  }

  void _listenStartAnimation() {
    widget.controller.stream.listen((event) async {
      if (!_startAnimation) {
        await Future.delayed(widget.delay, () {
          setState(() {
            _startAnimation = true;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return AnimatedOpacity(
      duration: Duration(milliseconds: 250),
      opacity: _startAnimation ? 1.0 : 0.0,
      child: _buildFeatureItem(screenWidth),
    );
  }

  Widget _buildFeatureItem(double screenWidth) {
    if (screenWidth <= SMALL_SCREEN_WIDTH) {
      return _buildSmallFeature();
    } else if (screenWidth > SMALL_SCREEN_WIDTH &&
        screenWidth <= MEDIUM_SCREEN_WIDTH) {
      return _buildMediumFeature();
    } else {
      return _buildBigFeature();
    }
  }

  Widget _buildBigFeature() {
    return Column(
      children: <Widget>[
        Transform.translate(
          offset: widget.imageOffset,
          child: Image.asset(widget.imagePath),
        ),
        SizedBox(height: 66),
        AutoSizeText(
          widget.title,
          textAlign: TextAlign.center,
          style: subtitleTextStyle(),
        ),
        SizedBox(height: 40),
        Text(
          widget.description,
          textAlign: TextAlign.center,
          style: bodyTextStyle(),
        ),
      ],
    );
  }

  Widget _buildMediumFeature() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Spacer(),
        if (!widget.isRightSide) Image.asset(widget.imagePath),
        if (!widget.isRightSide) SizedBox(width: 50),
        Column(
          crossAxisAlignment: widget.isRightSide
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.title,
              style: subtitleTextStyle(),
            ),
            SizedBox(height: 20),
            Container(
              width: 600,
              child: Text(
                widget.description,
                textAlign: widget.isRightSide ? TextAlign.end : TextAlign.start,
                style: bodyTextStyle(),
              ),
            ),
          ],
        ),
        if (widget.isRightSide) SizedBox(width: 80),
        if (widget.isRightSide) Image.asset(widget.imagePath),
        Spacer(),
      ],
    );
  }

  Widget _buildSmallFeature() {
    return Column(
      children: <Widget>[
        Image.asset(widget.imagePath),
        SizedBox(height: 32.0),
        Text(
          widget.title,
          style: subtitleTextStyle(fontSize: 28.0),
        ),
        SizedBox(height: 19.0),
        Container(
          width: 500,
          child: Text(
            widget.description,
            textAlign: TextAlign.center,
            style: bodyTextStyle(),
          ),
        ),
      ],
    );
  }
}
