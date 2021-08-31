import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:my_anime/ui/app/app_component.dart';
import 'package:my_anime/ui/screens/main_screen/main_screen_wm.dart';
import 'package:my_anime/ui/screens/top_anime_screen/top_anime_screen.dart';
import 'package:my_anime/ui/screens/top_anime_screen/top_anime_screen_component.dart';
import 'package:relation/relation.dart';
import 'package:surf_injector/surf_injector.dart';

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
  Widget build(BuildContext context) => StreamedStateBuilder<int>(
        streamedState: wm.selectedScreenIndexState,
        builder: (_, selectedScreenIndex) => Scaffold(
          body: _getScreen(selectedScreenIndex),
          bottomNavigationBar: MainScreenBottomBar(selectedScreenIndex, wm.navigationTap),
        ),
      );

  Widget _getScreen(int index) {
    final screens = [
      Injector<TopAnimeScreenComponent>(
        component: TopAnimeScreenComponent(
          Injector.of<AppComponent>(context).component.animeRepository,
        ),
        builder: (_) => TopAnimeScreen(),
      ),
      Center(
        child: Text(
          'Favorites screen',
        ),
      ),
    ];
    return screens[index];
  }
}

class MainScreenBottomBar extends StatelessWidget {
  final void Function(int) _callback;
  final int _index;
  const MainScreenBottomBar(this._index, this._callback, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        const BottomNavigationBarItem(
          icon: const Icon(Icons.view_list_rounded),
          label: 'Top',
        ),
        const BottomNavigationBarItem(
          icon: const Icon(Icons.favorite),
          label: 'Favorites',
        ),
      ],
      currentIndex: _index,
      selectedItemColor: Colors.green[800],
      onTap: _callback,
    );
  }
}
