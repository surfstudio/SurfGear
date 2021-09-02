import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:relation/relation.dart';
import 'package:tabnavigator/tabnavigator.dart';
import 'package:my_anime/ui/screens/main_screen/main_screen_tabs.dart';
import 'package:my_anime/ui/screens/main_screen/main_screen_wm.dart';

class MainScreen extends CoreMwwmWidget<MainScreenWM> {
  MainScreen({Key? key})
      : super(
          key: key,
          widgetModelBuilder: (context) {
            return MainScreenWM();
          },
        );

  @override
  WidgetState<MainScreen, MainScreenWM> createWidgetState() => _MainScreenState();
}

class _MainScreenState extends WidgetState<MainScreen, MainScreenWM> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: TabNavigator(
          key: wm.tabNavigatorKey,
          initialTab: MainScreenTabs.initTab,
          mappedTabs: MainScreenTabs.mappedTabs(),
          selectedTabStream: wm.selectedTabState.stream,
        ),
        bottomNavigationBar: StreamedStateBuilder<TabType>(
          streamedState: wm.selectedTabState,
          builder: (_, tabType) => _MainBottomNavigationBar(tabType, wm.navigationTap),
        ),
      );
}

class _MainBottomNavigationBar extends StatelessWidget {
  final TabType tabType;
  final void Function(int) onTap;

  const _MainBottomNavigationBar(this.tabType, this.onTap, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: MainScreenTabs.getTabBarItems(),
      currentIndex: tabType.value,
      selectedItemColor: Colors.green[800],
      onTap: onTap,
    );
  }
}
