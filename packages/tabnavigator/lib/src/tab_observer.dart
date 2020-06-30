import 'dart:async';

import 'package:tabnavigator/tabnavigator.dart';

class TabObserver {
  final Map<TabType, StreamController<TabState>> _tabControllers = {};

  Stream observeShowTab(TabType type) => _tabControllers[type]
      ?.stream
      ?.where((lifecycleState) => lifecycleState == TabState.show);

  Stream observeHideTab(TabType type) => _tabControllers[type]
      ?.stream
      ?.where((lifecycleState) => lifecycleState == TabState.hidden);

  Stream observeDoubleTap(TabType type) => _tabControllers[type]
      ?.stream
      ?.where((state) => state == TabState.double_tapped);

  void toggleActiveTab(TabType activeTab) {
    _tabControllers.forEach((type, controller) {
      if (type != activeTab) {
        controller.add(TabState.hidden);
      }
    });

    _tabControllers[activeTab]?.add(
      TabState.show,
    );
  }

  void addTab(TabType tab) {
    _tabControllers.putIfAbsent(
      tab,
      () => StreamController<TabState>.broadcast(),
    );
  }

  void onDoubleTapped(TabType tabType) {
    _tabControllers[tabType]?.add(TabState.double_tapped);
  }

  void dispose() {
    _tabControllers.forEach((_, c) => c.close);
  }
}
