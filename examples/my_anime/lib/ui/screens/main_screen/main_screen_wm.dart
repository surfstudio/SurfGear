import 'package:flutter/widgets.dart';
import 'package:mwwm/mwwm.dart';
import 'package:my_anime/ui/screens/main_screen/main_screen_tabs.dart';
import 'package:relation/relation.dart';
import 'package:tabnavigator/tabnavigator.dart';

class MainScreenWM extends WidgetModel {
  /// Поток с выбранными табами
  final StreamedState<TabType> selectedTabState = StreamedState(MainScreenTabs.initTab);

  final tabNavigatorKey = GlobalKey<TabNavigatorState>();

  MainScreenWM() : super(const WidgetModelDependencies());

  void navigationTap(int tabId) {
    final tabType = MainScreenTabs.byValue(tabId);
    selectedTabState.accept(tabType);
  }
}
