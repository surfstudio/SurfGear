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

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tabnavigator/tabnavigator.dart';

// ignore_for_file: avoid-returning-widgets

typedef TabBuilder = Widget Function();
typedef ObserversBuilder = List<NavigatorObserver> Function(TabType tabType);

Type _typeOf<T>() => T;

Widget _defaultTransitionBuilder(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) =>
    child;

/// Implementation of tab navigation
class TabNavigator extends StatefulWidget {
  const TabNavigator({
    required this.mappedTabs,
    required this.selectedTabStream,
    required this.initialTab,
    Key? key,
    this.onActiveTabReopened,
    this.observersBuilder,
    this.transitionsBuilder = _defaultTransitionBuilder,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.onGenerateRoute,
  }) : super(key: key);

  final Map<TabType, TabBuilder> mappedTabs;
  final Stream<TabType> selectedTabStream;
  final TabType initialTab;
  final void Function(BuildContext, TabType)? onActiveTabReopened;
  final ObserversBuilder? observersBuilder;
  final RouteTransitionsBuilder transitionsBuilder;
  final Duration transitionDuration;
  final RouteFactory? onGenerateRoute;

  static TabNavigatorState of(BuildContext context) {
    final type = _typeOf<TabNavigatorState>();
    TabNavigatorState? tabNavigator;
    tabNavigator = context.findAncestorStateOfType<TabNavigatorState>();
    if (tabNavigator == null) {
      throw Exception(
        'Can not find nearest _TabNavigator of type $type. Do you define it?',
      );
    }

    return tabNavigator;
  }

  @override
  TabNavigatorState createState() => TabNavigatorState();
}

class TabNavigatorState extends State<TabNavigator> {
  final List<TabType> _initializedTabs = [];
  final Map<TabType, GlobalKey<NavigatorState>> mappedNavKeys = {};
  final TabObserver tabObserver = TabObserver();
  late ValueNotifier<TabType> _activeTab;

  @override
  void initState() {
    super.initState();
    _activeTab = ValueNotifier(widget.initialTab)
      ..addListener(() {
        tabObserver.toggleActiveTab(_activeTab.value);
      });

    // to track clicks on the tab
    widget.selectedTabStream.listen(
      (tabType) {
        if (tabType.value == TabType.emptyValue) {
          _initializedTabs.clear();
          mappedNavKeys.clear();
        } else {
          if (_activeTab.value == tabType) {
            tabObserver.onDoubleTapped(tabType);
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TabType>(
      stream: widget.selectedTabStream,
      initialData: widget.initialTab,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return const SizedBox();
        }
        final tabType = snapshot.data!;
        if (tabType.value != TabType.emptyValue &&
            !_initializedTabs.contains(tabType)) {
          _initializedTabs.add(tabType);
          tabObserver.addTab(tabType);
        }

        _activeTab.value = tabType;
        return Stack(children: _buildTabs(tabType));
      },
    );
  }

  @override
  void dispose() {
    tabObserver.dispose();
    mappedNavKeys.clear();
    _activeTab.dispose();
    super.dispose();
  }

  List<Widget> _buildTabs(TabType selectedTab) {
    if (selectedTab.value != TabType.emptyValue) {
      mappedNavKeys.putIfAbsent(
        selectedTab,
        () => GlobalKey(debugLabel: '$selectedTab'),
      );
    }
    return [
      for (TabType tabType in _initializedTabs)
        WillPopScope(
          onWillPop: () => _willPop(tabType),
          child: Offstage(
            key: ValueKey(tabType.value),
            offstage: tabType != selectedTab,
            child: HeroControllerScope(
              controller: MaterialApp.createMaterialHeroController(),
              child: Navigator(
                key: mappedNavKeys[tabType],
                observers: widget.observersBuilder != null
                    ? widget.observersBuilder!(tabType)
                    : [],
                onGenerateRoute: (rs) => rs.name == Navigator.defaultRouteName
                    ? PageRouteBuilder<Object>(
                        settings: const RouteSettings(
                          name: Navigator.defaultRouteName,
                        ),
                        transitionsBuilder: widget.transitionsBuilder,
                        transitionDuration: widget.transitionDuration,
                        pageBuilder: (
                          context,
                          animation,
                          secondaryAnimation,
                        ) {
                          return widget.mappedTabs[tabType]!();
                        },
                      )
                    : widget.onGenerateRoute?.call(rs),
              ),
            ),
          ),
        ),
    ];
  }

  Future<bool> _willPop(TabType tabType) async {
    final maybePop =
        mappedNavKeys[tabType]?.currentState?.maybePop() ?? Future.value(false);

    return !(await maybePop);
  }
}
