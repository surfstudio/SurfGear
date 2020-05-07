import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:surfgear_webpage/assets/images.dart';
import 'package:surfgear_webpage/pages/main/body/main_page_body.dart';
import 'package:surfgear_webpage/pages/main/main_page_footer.dart';
import 'package:surfgear_webpage/pages/main/main_page_header.dart';

/// Medium screen width
const double MEDIUM_SCREEN_WIDTH = 1500;

/// Small screen width
const double SMALL_SCREEN_WIDTH = 800;

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage>
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
                    child: MainPageHeader(),
                  ),
                  StreamBuilder(
                    stream: _pageOffsetController.stream,
                    initialData: 0.0,
                    builder: (context, offset) {
                      return MainPageBody(offset.data);
                    },
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints.expand(
                      height: MediaQuery.of(context).size.height,
                    ),
                    child: MainPageFooter(
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
