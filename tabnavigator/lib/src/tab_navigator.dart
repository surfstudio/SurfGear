import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tabnavigator/tabnavigator.dart';

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
  final Map<TabType, TabBuilder> mappedTabs;
  final Stream<TabType> selectedTabStream;
  final TabType initialTab;
  final void Function(BuildContext, TabType) onActiveTabReopened;
  final ObserversBuilder observersBuilder;
  final RouteTransitionsBuilder transitionsBuilder;
  final Duration transitionDuration;
  final RouteFactory onGenerateRoute;

  static TabNavigatorState of(BuildContext context) {
    Type type = _typeOf<TabNavigatorState>();
    TabNavigatorState tabNavigator;
    tabNavigator =
        context.ancestorStateOfType(const TypeMatcher<TabNavigatorState>());
    if (tabNavigator == null) {
      throw Exception(
          "Can not find nearest _TabNavigator of type $type. Do you define it?");
    }

    return tabNavigator;
  }

  const TabNavigator({
    Key key,
    @required this.mappedTabs,
    @required this.selectedTabStream,
    @required this.initialTab,
    this.onActiveTabReopened,
    this.observersBuilder,
    RouteTransitionsBuilder transitionsBuilder,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.onGenerateRoute,
  })  : assert(mappedTabs != null),
        assert(selectedTabStream != null),
        assert(initialTab != null),
        this.transitionsBuilder =
            transitionsBuilder ?? _defaultTransitionBuilder,
        super(key: key);

  @override
  TabNavigatorState createState() => TabNavigatorState();
}

class TabNavigatorState extends State<TabNavigator> {
  final List<TabType> _initializedTabs = [];
  final Map<TabType, GlobalKey<NavigatorState>> mappedNavKeys = {};
  final TabObserver tabObserver = TabObserver();
  ValueNotifier<TabType> _activeTab;

  @override
  void initState() {
    super.initState();
    _activeTab = ValueNotifier(widget.initialTab)
      ..addListener(() {
        tabObserver.toggleActiveTab(_activeTab.value);
      });

    // to track clicks on the tab
    widget.selectedTabStream.listen((tabType) {
      if (_activeTab.value == tabType) {
        tabObserver.onDoubleTapped(tabType);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TabType>(
      stream: widget.selectedTabStream,
      initialData: widget.initialTab,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.active) {
          return const SizedBox();
        }
        TabType tabType = snapshot.data;
        if (!_initializedTabs.contains(tabType)) {
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
    mappedNavKeys.putIfAbsent(
      selectedTab,
      () => GlobalKey(debugLabel: "$selectedTab"),
    );
    return [
      for (TabType tabType in _initializedTabs)
        WillPopScope(
          onWillPop: () async =>
              !await mappedNavKeys[tabType].currentState.maybePop(),
          child: Offstage(
            key: ValueKey(tabType.value),
            offstage: tabType != selectedTab,
            child: Navigator(
              key: mappedNavKeys[tabType],
              observers: widget.observersBuilder != null
                  ? widget.observersBuilder(tabType)
                  : [],
              onGenerateRoute: (rs) => rs.name == Navigator.defaultRouteName
                  ? PageRouteBuilder(
                      settings: RouteSettings(
                        isInitialRoute: true,
                        name: Navigator.defaultRouteName,
                      ),
                      transitionsBuilder: widget.transitionsBuilder,
                      transitionDuration: widget.transitionDuration,
                      pageBuilder: (
                        context,
                        animation,
                        secondaryAnimation,
                      ) =>
                          widget.mappedTabs[tabType](),
                    )
                  : widget.onGenerateRoute?.call(rs),
            ),
          ),
        )
    ];
  }
}
