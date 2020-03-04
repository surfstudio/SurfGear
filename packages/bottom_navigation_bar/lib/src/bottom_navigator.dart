// Copyright (c) 2019-present,  SurfStudio LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'dart:async';

import 'package:bottom_navigation_bar/src/bottom_nav_bar.dart';
import 'package:bottom_navigation_bar/src/bottom_nav_tab_type.dart';
import 'package:bottom_navigation_bar/src/bottom_navigation_relationship.dart';
import 'package:flutter/material.dart';
import 'package:tabnavigator/tabnavigator.dart';

/// Widget that display element by item currently selected in bottom bar.
class BottomNavigator extends StatefulWidget {
  final Map<BottomNavTabType, BottomNavigationRelationship> tabsMap;
  final BottomNavTabType initialTab;
  final StreamController<BottomNavTabType> selectController;

  final BottomNavBar bottomNavBar;

  const BottomNavigator({
    Key key,
    @required this.tabsMap,
    @required this.initialTab,
    this.selectController
  })  : bottomNavBar = null,
        super(key: key);

  /// In this case bottom navigation bar will be custom,
  /// and BottomNavigationRelationship.navElementBuilder will not be called.
  /// Also outer selector should be given into custom bottom navigation bar
  /// bypass bottom navigator.
  const BottomNavigator.custom({
    Key key,
    @required this.tabsMap,
    @required this.initialTab,
    @required this.bottomNavBar,
    @required this.selectController,
  })  : super(key: key);

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

  @override
  void closeSelectController() {
  }
}

class _BottomNavigatorState extends _BaseBottomNavigatorState {
  bool _isControllerOwner = false;
  StreamController<BottomNavTabType> _selectController;

  Map<BottomNavTabType, NavElementBuilder> _bottomMap =
      Map<BottomNavTabType, NavElementBuilder>();

  @override
  void initState() {
    super.initState();

    widget.tabsMap.forEach((tabType, relationship) {
      _bottomMap
          .addEntries([MapEntry(tabType, relationship.navElementBuilder)]);
    });
  }

  @override
  StreamController<BottomNavTabType> initSelectController() {
    if (widget.selectController == null) {
      _isControllerOwner = true;
      _selectController = StreamController<BottomNavTabType>.broadcast();
    } else {
      _selectController = widget.selectController;
    }

    return _selectController;
  }


  @override
  void closeSelectController() {
    if (_isControllerOwner) {
      _selectController.close();
    }
  }

  @override
  BottomNavBar buildBottomBar() {
    return BottomNavBar(
      initType: widget.initialTab,
      selectedController: _selectController,
      elements: _bottomMap,
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

    widget.tabsMap.forEach((tabType, relationship) {
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
  void closeSelectController();

  @protected
  BottomNavBar buildBottomBar();

  @override
  void dispose() {
    closeSelectController();

    super.dispose();
  }
}
