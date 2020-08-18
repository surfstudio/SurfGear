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

import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:mwwm_github_client/ui/main_screen/main_wm.dart';
import 'package:mwwm_github_client/ui/main_screen/pages/favorites/favorites_page.dart';
import 'package:mwwm_github_client/ui/main_screen/pages/repositories/repositories_page.dart';
import 'package:mwwm_github_client/ui/main_screen/pages/users/users_page.dart';
import 'package:relation/relation.dart';

/// Main screen
class MainScreen extends CoreMwwmWidget {
  MainScreen({
    @required WidgetModelBuilder widgetModelBuilder,
  })  : assert(widgetModelBuilder != null),
        super(widgetModelBuilder: widgetModelBuilder);

  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends WidgetState<MainWm> {
  @override
  Widget build(BuildContext context) => StreamedStateBuilder<int>(
        streamedState: wm.pageIndexState,
        builder: (context, pageIndex) => Scaffold(
          bottomNavigationBar: _buildBottomNavigationBar(pageIndex),
          body: IndexedStack(
            index: pageIndex,
            children: [
              RepositoriesPage(),
              FavoritesPage(),
              UsersPage(),
            ],
          ),
        ),
      );

  Widget _buildBottomNavigationBar(int pageIndex) => BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Repositories'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grade),
            title: Text('Favorites'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Users'),
          ),
        ],
        currentIndex: pageIndex,
        onTap: wm.changePageAction,
      );
}
