import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:my_anime/ui/screens/main_screen/main_screen_wm.dart';
import 'package:relation/relation.dart';

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
  static List<Widget> _screens = <Widget>[
    Center(
      child: Text(
        'Top anime screen',
      ),
    ),
    Center(
      child: Text(
        'Favorites screen',
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) => StreamedStateBuilder<int>(
        streamedState: wm.selectedScreenIndexState,
        builder: (_, selectedScreenIndex) => Scaffold(
          body: _screens.elementAt(selectedScreenIndex),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.view_list_rounded),
                label: 'Top',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorites',
              ),
            ],
            currentIndex: selectedScreenIndex,
            selectedItemColor: Colors.blue[800],
            onTap: wm.navigationTap,
          ),
        ),
      );
}
