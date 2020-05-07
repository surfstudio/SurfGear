import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:surfgear_webpage/assets/images.dart';
import 'package:surfgear_webpage/assets/text.dart';
import 'package:surfgear_webpage/assets/text_styles.dart';
import 'package:surfgear_webpage/common/animated_title.dart';
import 'package:surfgear_webpage/common/offset_animated_widget.dart';
import 'package:surfgear_webpage/pages/main/body/features/feature_item.dart';
import 'package:surfgear_webpage/pages/main/main_page.dart';

/// Features widget
class FeaturesWidget extends StatefulWidget {
  /// Webpage scroll offset
  final double scrollOffset;

  FeaturesWidget(this.scrollOffset);

  @override
  State<StatefulWidget> createState() {
    return FeaturesWidgetState();
  }
}

class FeaturesWidgetState extends State<FeaturesWidget> {
  /// Stream in which the animation start event is stored
  StreamController<bool> controller = StreamController.broadcast();

  bool _hasScrolled = false;

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return ScrollOffsetWidget(
      scrollOffset: widget.scrollOffset,
      hasScrolled: () {
        controller.add(true);
        setState(() {
          _hasScrolled = true;
        });
      },
      child: Column(
        children: <Widget>[
          _FeaturesTitle(widget.scrollOffset),
          _buildFeatures(screenWidth),
        ],
      ),
    );
  }

  Widget _buildFeatures(double screenWidth) {
    if (screenWidth <= SMALL_SCREEN_WIDTH) {
      return _buildSmallFeatures();
    } else if (screenWidth > SMALL_SCREEN_WIDTH &&
        screenWidth <= MEDIUM_SCREEN_WIDTH) {
      return _buildMediumFeatures();
    } else {
      return _buildBigFeatures();
    }
  }

  Widget _buildBigFeatures() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: <Widget>[
        Spacer(),
        Flexible(
          child: Transform.translate(
            offset: Offset(0.0, 0.0),
            child: FeatureItem(
              imagePath: icFeature1,
              title: feature1TitleText,
              description: feature1DescriptionText,
              delay: Duration(milliseconds: 50),
              controller: controller,
              imageOffset: Offset(25.0, 0.0),
            ),
          ),
        ),
        Spacer(),
        Flexible(
          child: FeatureItem(
            imagePath: icFeature2,
            title: feature2TitleText,
            description: feature2DescriptionText,
            delay: Duration(milliseconds: 100),
            controller: controller,
          ),
        ),
        Spacer(),
        Flexible(
          child: FeatureItem(
            imagePath: icFeature3,
            title: feature3TitleText,
            description: feature3DescriptionText,
            delay: Duration(milliseconds: 150),
            controller: controller,
          ),
        ),
        Spacer(),
      ],
    );
  }

  Widget _buildMediumFeatures() {
    return Column(
      children: <Widget>[
        FeatureItem(
          imagePath: icFeature1,
          title: feature1TitleText,
          description: feature1DescriptionText,
          delay: Duration(milliseconds: 50),
          controller: controller,
        ),
        SizedBox(height: 80),
        FeatureItem(
          imagePath: icFeature2,
          title: feature2TitleText,
          description: feature2DescriptionText,
          isRightSide: true,
          delay: Duration(milliseconds: 100),
          controller: controller,
        ),
        SizedBox(height: 80),
        FeatureItem(
          imagePath: icFeature3,
          title: feature3TitleText,
          description: feature3DescriptionText,
          delay: Duration(milliseconds: 150),
          controller: controller,
        ),
      ],
    );
  }

  Widget _buildSmallFeatures() {
    return Column(
      children: <Widget>[
        FeatureItem(
          imagePath: icFeature1,
          title: feature1TitleText,
          description: feature1DescriptionText,
          delay: Duration(milliseconds: 50),
          controller: controller,
        ),
        SizedBox(height: 145),
        FeatureItem(
          imagePath: icFeature2,
          title: feature2TitleText,
          description: feature2DescriptionText,
          isRightSide: true,
          delay: Duration(milliseconds: 100),
          controller: controller,
        ),
        SizedBox(height: 125),
        FeatureItem(
          imagePath: icFeature3,
          title: feature3TitleText,
          description: feature3DescriptionText,
          delay: Duration(milliseconds: 150),
          controller: controller,
        ),
      ],
    );
  }
}

/// Features title
class _FeaturesTitle extends StatefulWidget {
  /// Webpage scroll offset
  final double scrollOffset;

  _FeaturesTitle(this.scrollOffset);

  @override
  State<StatefulWidget> createState() {
    return _FeaturesTitleState();
  }
}

class _FeaturesTitleState extends State<_FeaturesTitle> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= SMALL_SCREEN_WIDTH) {
      return Column(
        children: <Widget>[
          SizedBox(height: 118),
          AnimatedTitle(
            featuresTitleText,
            headlineTextStyle(fontSize: 28.0),
            Duration(milliseconds: 250),
            widget.scrollOffset,
          ),
          SizedBox(height: 80),
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          SizedBox(height: 210),
          AnimatedTitle(
            featuresTitleText,
            headlineTextStyle(),
            Duration(milliseconds: 250),
            widget.scrollOffset,
          ),
          SizedBox(height: 110),
        ],
      );
    }
  }
}
