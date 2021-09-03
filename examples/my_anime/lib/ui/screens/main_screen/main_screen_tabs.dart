import 'package:flutter/material.dart';
import 'package:my_anime/ui/app/app_component.dart';
import 'package:my_anime/ui/screens/top_anime_screen/top_anime_screen.dart';
import 'package:my_anime/ui/screens/top_anime_screen/top_anime_screen_component.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:tabnavigator/tabnavigator.dart';

class MainScreenTabs {
  static final Set<ScreenTabItem> tabs = {
    /// топ
    const ScreenTabItem(
      type: MainScreenTabType.top,
      bottomNavigationIcon: TabBarItem(
        icon: Icon(Icons.view_list_rounded),
        text: 'Top',
      ),
    ),

    /// избранные
    const ScreenTabItem(
      type: MainScreenTabType.favorites,
      bottomNavigationIcon: TabBarItem(
        icon: Icon(Icons.favorite),
        text: 'Favorites',
      ),
    ),
  };

  static TabType get initTab => tabs.first.type;

  MainScreenTabs();

  /// получить набор табов
  static Map<TabType, TabBuilder> mappedTabs(BuildContext context) {
    return {
      MainScreenTabType.top: () => Injector(
            component: TopAnimeScreenComponent(
              Injector.of<AppComponent>(context).component.animeInteractor,
              Navigator.of(context),
            ),
            builder: (_) => const TopAnimeScreen(),
          ),
      MainScreenTabType.favorites: () => const Center(
            child: Text('Favorites'),
          ),
    };
  }

  /// получить набор иконок для нижнего таббара
  static List<BottomNavigationBarItem> getTabBarItems() {
    return tabs.map((tabItem) => tabItem.bottomNavigationIcon.build()).toList();
  }

  /// получить тип таба по id
  static TabType byValue(int tabId) => tabs.firstWhere((element) => element.type.value == tabId).type;
}

class MainScreenTabType extends TabType {
  static const top = MainScreenTabType._(0);
  static const favorites = MainScreenTabType._(1);

  const MainScreenTabType._(int value) : super(value);

  static MainScreenTabType byValue(int ordinal) {
    switch (ordinal) {
      case 0:
        return top;
      case 1:
        return favorites;
      default:
        return top;
    }
  }
}

@immutable
class ScreenTabItem {
  final TabType type;
  final TabBarItem bottomNavigationIcon;

  @override
  int get hashCode => type.hashCode;

  const ScreenTabItem({
    required this.type,
    required this.bottomNavigationIcon,
  });

  @override
  bool operator ==(Object other) => other is ScreenTabItem && other.type == type;
}

/// Набор данных необходимы для иконки нижнем таб баре
class TabBarItem {
  final Icon icon;
  final String text;

  const TabBarItem({
    required this.icon,
    required this.text,
  });

  BottomNavigationBarItem build() {
    return BottomNavigationBarItem(
      icon: icon,
      label: text,
    );
  }
}
