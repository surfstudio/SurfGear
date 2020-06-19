import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:mwwm_github_client/ui/main_screen/main_wm.dart';
import 'package:mwwm_github_client/ui/main_screen/pages/favorites/favorites_page.dart';
import 'package:mwwm_github_client/ui/main_screen/pages/repositories/repositories_page.dart';
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
              const Center(child: Text('3')),
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
