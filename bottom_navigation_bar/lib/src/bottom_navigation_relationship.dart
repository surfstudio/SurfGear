import 'package:bottom_navigation_bar/src/bottom_nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:tabnavigator/tabnavigator.dart';

/// Class describes relations between navigation widget and content widget.
class BottomNavigationRelationship {
  final TabBuilder tabBuilder;
  final NavElementBuilder navElementBuilder;

  BottomNavigationRelationship({
    @required this.tabBuilder,
    @required this.navElementBuilder,
  });
}
