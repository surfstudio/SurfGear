import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:surfgear_webpage/modules.dart';
import 'package:surfgear_webpage/pages/main/body/carousel/library_carousel.dart';
import 'package:surfgear_webpage/pages/main/body/carousel/library_item.dart';
import 'package:surfgear_webpage/pages/main/body/features/features_widget.dart';

/// Webpage body
class MainPageBody extends StatefulWidget {
  final double scrollOffset;

  MainPageBody(this.scrollOffset);

  @override
  State<StatefulWidget> createState() {
    return _MainPageBodyState();
  }
}

class _MainPageBodyState extends State<MainPageBody> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return FutureBuilder<List<Module>>(
      future: modules,
      builder: (context, snapshot) {
        if (snapshot.data == null) return SizedBox();

        return Column(
          children: <Widget>[
            Carousel(
              widget.scrollOffset,
              screenWidth,
              snapshot.data
                  .map((m) => LibraryItem(title: m.name, imagePath: m.imgPath))
                  .toList(),
            ),
            FeaturesWidget(widget.scrollOffset),
            SizedBox(height: 200),
          ],
        );
      },
    );
  }
}
