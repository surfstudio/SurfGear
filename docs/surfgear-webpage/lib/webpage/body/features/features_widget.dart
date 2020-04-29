import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:surfgear_webpage/assets/images.dart';
import 'package:surfgear_webpage/assets/text.dart';
import 'package:surfgear_webpage/assets/text_styles.dart';
import 'package:surfgear_webpage/webpage/body/features/feature_item.dart';
import 'package:surfgear_webpage/webpage/common/animated_title.dart';
import 'package:surfgear_webpage/webpage/common/offset_animated_widget.dart';
import 'package:surfgear_webpage/webpage/webpage_widget.dart';

/// Виджет с фичами
/// https://www.figma.com/file/FTTXzwb6zPFZtOhGK0PAKl/Untitled?node-id=3%3A0
class FeaturesWidget extends StatefulWidget {
  /// положение скролла
  final double scrollOffset;

  FeaturesWidget(this.scrollOffset);

  @override
  State<StatefulWidget> createState() {
    return FeaturesWidgetState();
  }
}

class FeaturesWidgetState extends State<FeaturesWidget> {
  /// Стрим, в котором хранится событие начала анимации для фичей
  StreamController<bool> controller = StreamController.broadcast();

  @override
  void dispose() {
    super.dispose();
    controller.close();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return ScrollOffsetWidget(
      scrollOffset: widget.scrollOffset,
      hasScrolled: () {
        controller.add(true);
      },
      child: Column(
        children: <Widget>[
          _FeaturesTitle(widget.scrollOffset),
          _buildFeatures(screenWidth),
        ],
      ),
    );
  }

  /// Отрисовать фичи
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

  /// Отрисовать большие фичи
  Widget _buildBigFeatures() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Spacer(),
            FeatureItem(
              imagePath: feature1ImgPath,
              title: feature1TitleText,
              description: feature1DescriptionText,
              delay: Duration(milliseconds: 50),
              controller: controller,
            ),
            Spacer(),
            FeatureItem(
              imagePath: feature2ImgPath,
              title: feature2TitleText,
              description: feature2DescriptionText,
              delay: Duration(milliseconds: 100),
              controller: controller,
            ),
            Spacer(),
            FeatureItem(
              imagePath: feature3ImgPath,
              title: feature3TitleText,
              description: feature3DescriptionText,
              delay: Duration(milliseconds: 150),
              controller: controller,
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }

  /// Отрисовать средние фичи
  Widget _buildMediumFeatures() {
    return Column(
      children: <Widget>[
        FeatureItem(
          imagePath: feature1ImgPath,
          title: feature1TitleText,
          description: feature1DescriptionText,
          delay: Duration(milliseconds: 50),
          controller: controller,
        ),
        SizedBox(height: 80),
        FeatureItem(
          imagePath: feature2ImgPath,
          title: feature2TitleText,
          description: feature2DescriptionText,
          isRightSide: true,
          delay: Duration(milliseconds: 100),
          controller: controller,
        ),
        SizedBox(height: 80),
        FeatureItem(
          imagePath: feature3ImgPath,
          title: feature3TitleText,
          description: feature3DescriptionText,
          delay: Duration(milliseconds: 150),
          controller: controller,
        ),
      ],
    );
  }

  /// Отрисовать маленькие фичи
  Widget _buildSmallFeatures() {
    return Column(
      children: <Widget>[
        FeatureItem(
          imagePath: feature1ImgPath,
          title: feature1TitleText,
          description: feature1DescriptionText,
          delay: Duration(milliseconds: 50),
          controller: controller,
        ),
        SizedBox(height: 145),
        FeatureItem(
          imagePath: feature2ImgPath,
          title: feature2TitleText,
          description: feature2DescriptionText,
          isRightSide: true,
          delay: Duration(milliseconds: 100),
          controller: controller,
        ),
        SizedBox(height: 125),
        FeatureItem(
          imagePath: feature3ImgPath,
          title: feature3TitleText,
          description: feature3DescriptionText,
          delay: Duration(milliseconds: 150),
          controller: controller,
        ),
      ],
    );
  }
}

/// Заголовок фичей
/// https://www.figma.com/file/FTTXzwb6zPFZtOhGK0PAKl/Untitled?node-id=13%3A12
class _FeaturesTitle extends StatefulWidget {
  /// Положение скролла
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
            rubikBlackNormal28,
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
            rubikBlackNormal38,
            Duration(milliseconds: 250),
            widget.scrollOffset,
          ),
          SizedBox(height: 110),
        ],
      );
    }
  }
}
