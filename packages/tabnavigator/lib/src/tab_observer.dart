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

import 'package:tabnavigator/src/tab_state.dart';
import 'package:tabnavigator/tabnavigator.dart';

class TabObserver {
  final _tabControllers = <TabType, StreamController<TabState>>{};

  Stream? observeShowTab(TabType type) => _tabControllers[type]
      ?.stream
      .where((lifecycleState) => lifecycleState == TabState.show);

  Stream? observeHideTab(TabType type) => _tabControllers[type]
      ?.stream
      .where((lifecycleState) => lifecycleState == TabState.hidden);

  Stream? observeDoubleTap(TabType type) => _tabControllers[type]
      ?.stream
      .where((state) => state == TabState.doubleTapped);

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
    _tabControllers[tabType]?.add(TabState.doubleTapped);
  }

  Future<void> dispose() async {
    for (final controller in _tabControllers.values) {
      await controller.close();
    }
  }
}
