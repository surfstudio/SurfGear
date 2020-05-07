import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:surfgear_webpage/webpage/body/carousel/library_carousel.dart';
import 'package:surfgear_webpage/webpage/body/features/features_widget.dart';
import 'package:surfgear_webpage/webpage/body/libraries.dart';

/// Webpage body
class BodyWidget extends StatefulWidget {
  final double scrollOffset;

  BodyWidget(this.scrollOffset);

  @override
  State<StatefulWidget> createState() {
    return _BodyWidgetState();
  }
}

class _BodyWidgetState extends State<BodyWidget> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return FutureBuilder(
      future: DefaultAssetBundle.of(context)
          .loadString('assets/libraries_config.json'),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          List<String> librariesList = getLibrariesList(snapshot.data);
          return Column(
            children: <Widget>[
              Carousel(
                widget.scrollOffset,
                screenWidth,
                getLibraries(librariesList),
              ),
              FeaturesWidget(widget.scrollOffset),
              SizedBox(height: 200),
            ],
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
