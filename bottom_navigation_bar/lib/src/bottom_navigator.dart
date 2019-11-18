import 'dart:async';

import 'package:bottom_navigation_bar/src/bottom_nav_bar.dart';
import 'package:bottom_navigation_bar/src/bottom_nav_tab_type.dart';
import 'package:bottom_navigation_bar/src/bottom_navigation_relationship.dart';
import 'package:flutter/material.dart';
import 'package:tabnavigator/tabnavigator.dart';

/// Widget that display element by current item in bottom bar.
class BottomNavigator extends StatefulWidget {
  final Map<BottomNavTabType, BottomNavigationRelationship> map;
  final BottomNavTabType initialTab;

  const BottomNavigator({
    Key key,
    @required this.map,
    @required this.initialTab,
  }) : super(key: key);

  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  StreamController<BottomNavTabType> _selectController =
      StreamController<BottomNavTabType>.broadcast();

  Map<BottomNavTabType, TabBuilder> _navigatorMap = Map<BottomNavTabType, TabBuilder>();
  Map<BottomNavTabType, NavElementBuilder> _bottomMap = Map<BottomNavTabType, NavElementBuilder>();

  @override
  void initState() {
    super.initState();

    _selectController.add(widget.initialTab);

    widget.map.forEach((tabType, relationship) {
      _navigatorMap.addEntries([MapEntry(tabType, relationship.tabBuilder)]);
      _bottomMap
          .addEntries([MapEntry(tabType, relationship.navElementBuilder)]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: TabNavigator(
            initialTab: widget.initialTab,
            selectedTabStream: _selectController.stream,
            mappedTabs: _navigatorMap,
          ),
        ),
        BottomNavBar(
          initType: widget.initialTab,
          selected: _selectController.sink,
          elements: _bottomMap,
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();

    _selectController.close();
  }
}