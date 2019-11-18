import 'dart:async';

import 'package:bottom_navigation_bar/src/bottom_nav_bar.dart';
import 'package:bottom_navigation_bar/src/bottom_nav_tab_type.dart';
import 'package:bottom_navigation_bar/src/bottom_navigation_relationship.dart';
import 'package:flutter/material.dart';
import 'package:tabnavigator/tabnavigator.dart';

/// Widget that display element by item currently selected in bottom bar.
class BottomNavigator extends StatefulWidget {
  final Map<BottomNavTabType, BottomNavigationRelationship> map;
  final BottomNavTabType initialTab;
  final Stream<BottomNavTabType> outerSelector;

  final BottomNavBar bottomNavBar;
  final StreamController<BottomNavTabType> selectController;

  const BottomNavigator({
    Key key,
    @required this.map,
    @required this.initialTab,
    this.outerSelector,
  })  : bottomNavBar = null,
        selectController = null,
        super(key: key);

  /// In this case bottom navigation bar will be custom,
  /// and BottomNavigationRelationship.navElementBuilder could not be called.
  /// Also outer selector should be given into custom bottom navigation bar
  /// bypass bottom navigator.
  const BottomNavigator.custom({
    Key key,
    @required this.map,
    @required this.initialTab,
    @required this.bottomNavBar,
    @required this.selectController,
  })  : outerSelector = null,
        super(key: key);

  @override
  _BaseBottomNavigatorState createState() => bottomNavBar == null
      ? _BottomNavigatorState()
      : _CustomBottomNavigatorState();
}

class _CustomBottomNavigatorState extends _BaseBottomNavigatorState {
  @override
  BottomNavBar buildBottomBar() {
    return widget.bottomNavBar;
  }

  @override
  StreamController<BottomNavTabType> initSelectController() {
    return widget.selectController;
  }
}

class _BottomNavigatorState extends _BaseBottomNavigatorState {
  Map<BottomNavTabType, NavElementBuilder> _bottomMap =
      Map<BottomNavTabType, NavElementBuilder>();

  @override
  void initState() {
    super.initState();

    widget.map.forEach((tabType, relationship) {
      _bottomMap
          .addEntries([MapEntry(tabType, relationship.navElementBuilder)]);
    });
  }

  @override
  StreamController<BottomNavTabType> initSelectController() {
    return StreamController<BottomNavTabType>.broadcast();
  }

  @override
  BottomNavBar buildBottomBar() {
    return BottomNavBar(
      initType: widget.initialTab,
      selected: _selectController.sink,
      elements: _bottomMap,
      outerSelector: widget.outerSelector,
    );
  }
}

abstract class _BaseBottomNavigatorState extends State<BottomNavigator> {
  StreamController<BottomNavTabType> _selectController;

  Map<BottomNavTabType, TabBuilder> _navigatorMap =
      Map<BottomNavTabType, TabBuilder>();

  @override
  void initState() {
    super.initState();

    _selectController = initSelectController();
    _selectController.add(widget.initialTab);

    widget.map.forEach((tabType, relationship) {
      _navigatorMap.addEntries([MapEntry(tabType, relationship.tabBuilder)]);
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
        buildBottomBar(),
      ],
    );
  }

  @protected
  StreamController<BottomNavTabType> initSelectController();

  @protected
  BottomNavBar buildBottomBar();

  @override
  void dispose() {
    super.dispose();

    _selectController?.close();
  }
}
