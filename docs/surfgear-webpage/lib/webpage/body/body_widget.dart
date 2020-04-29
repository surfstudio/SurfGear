import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:surfgear_webpage/assets/images.dart';
import 'package:surfgear_webpage/webpage/body/carousel/library_carousel.dart';
import 'package:surfgear_webpage/webpage/body/carousel/library_item.dart';
import 'package:surfgear_webpage/webpage/body/features/features_widget.dart';

/// Тело странички
/// https://www.figma.com/file/FTTXzwb6zPFZtOhGK0PAKl/Untitled?node-id=13%3A12
class BodyWidget extends StatefulWidget {
  final double scrollOffset;

  BodyWidget(this.scrollOffset);

  @override
  State<StatefulWidget> createState() {
    return _BodyWidgetState();
  }
}

class _BodyWidgetState extends State<BodyWidget> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
        Carousel(
          widget.scrollOffset,
          screenWidth,

          /// TODO необходимо определиться какие библиотеки будут в карусели
          /// TODO сделать для них картинки
          [
            LibraryItem(
              title: "background_worker",
              imagePath: icTestLib,
            ),
            LibraryItem(
              title: "mwwm",
              imagePath: icTestLib,
            ),
            LibraryItem(
              title: "bottom_sheet",
              imagePath: icTestLib,
            ),
            LibraryItem(
              title: "geolocator",
              imagePath: icTestLib,
            ),
            LibraryItem(
              title: "permission",
              imagePath: icTestLib,
            ),
            LibraryItem(
              title: "bottom_navigation_bar",
              imagePath: icTestLib,
            ),
          ],
        ),
        FeaturesWidget(widget.scrollOffset),
        SizedBox(height: 200),
      ],
    );
  }
}