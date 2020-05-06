import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:surfgear_webpage/assets/images.dart';
import 'package:surfgear_webpage/webpage/body/body_widget.dart';
import 'package:surfgear_webpage/webpage/footer/footer_widget.dart';
import 'package:surfgear_webpage/webpage/header/header_widget.dart';

/// Medium screen width
const double MEDIUM_SCREEN_WIDTH = 1500;

/// Small screen width
const double SMALL_SCREEN_WIDTH = 800;

class WebpageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WebpageWidgetState();
  }
}

class _WebpageWidgetState extends State<WebpageWidget>
    with SingleTickerProviderStateMixin {
  /// Stream for storing page scroll position
  StreamController _pageOffsetController = StreamController<double>.broadcast();

  /// Page ScrollController
  ScrollController _pageScrollController;

  @override
  void initState() {
    super.initState();
    _initScrollControllerListener();
  }

  void _initScrollControllerListener() {
    _pageScrollController = ScrollController()
      ..addListener(
        () {
          var scrollOffset = _pageScrollController.offset;
          _pageOffsetController.add(scrollOffset);
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        controller: _pageScrollController,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onVerticalDragStart: (_) {},
          child: Stack(
            children: [
              _buildSurfLogo(),
              Column(
                children: <Widget>[
                  ConstrainedBox(
                    constraints: BoxConstraints.expand(
                      height: MediaQuery.of(context).size.height,
                    ),
                    child: HeaderWidget(),
                  ),
                  StreamBuilder(
                    stream: _pageOffsetController.stream,
                    initialData: 0.0,
                    builder: (context, offset) {
                      return BodyWidget(offset.data);
                    },
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints.expand(
                      height: MediaQuery.of(context).size.height,
                    ),
                    child: FooterWidget(
                      scrollChangesStream: _pageOffsetController.stream,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSurfLogo() {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(
        height: MediaQuery.of(context).size.height * 3,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          OverflowBox(
            minWidth: 800,
            maxWidth: double.infinity,
            alignment: Alignment(-0.3, -0.1),
            child: Image.asset(
              imgBackgroundLogo,
              fit: BoxFit.fitWidth,
              width: MediaQuery.of(context).size.width <= SMALL_SCREEN_WIDTH
                  ? MediaQuery.of(context).size.width
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
