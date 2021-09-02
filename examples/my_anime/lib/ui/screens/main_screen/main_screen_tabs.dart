import 'package:flutter/material.dart';
import 'package:my_anime/ui/screens/top_anime_screen/top_anime_screen.dart';
import 'package:tabnavigator/tabnavigator.dart';

class MainScreenTabs {
  MainScreenTabs();

  static TabType get initTab => tabs.first.type;

  /// получить набор табов
  static Map<TabType, TabBuilder> mappedTabs() {
    return Map.fromEntries(
      tabs.map((tabItem) => MapEntry(tabItem.type, () => tabItem.screen)),
    );
  }

  /// получить набор иконок для нижнего таббара
  static List<BottomNavigationBarItem> getTabBarItems() {
    return tabs.map((tabItem) => tabItem.bottomNavigationIcon.build()).toList();
  }

  /// получить тип таба по id
  static TabType byValue(int tabId) => tabs.firstWhere((element) => element.type.value == tabId).type;

  static final Set<ScreenTabItem> tabs = {
    /// топ
    const ScreenTabItem(
      type: MainScreenTabType.top,
      screen: TopAnimeScreen(),
      bottomNavigationIcon: TabBarItem(
        icon: Icon(Icons.view_list_rounded),
        text: 'Top',
      ),
    ),

    /// избранные
    const ScreenTabItem(
      type: MainScreenTabType.favorites,
      screen: Center(
        child: Text('favorites'),
      ),
      bottomNavigationIcon: TabBarItem(
        icon: Icon(Icons.favorite),
        text: 'Favorites',
      ),
    ),
  };
}

class MainScreenTabType extends TabType {
  const MainScreenTabType._(int value) : super(value);

  static const top = MainScreenTabType._(0);
  static const favorites = MainScreenTabType._(1);

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
  const ScreenTabItem({
    required this.type,
    required this.screen,
    required this.bottomNavigationIcon,
  });

  final TabType type;
  final Widget screen;
  final TabBarItem bottomNavigationIcon;

  @override
  bool operator ==(Object other) => other is ScreenTabItem && other.type == type;

  @override
  int get hashCode => type.hashCode;
}

/// Набор данных необходимы для иконки нижнем таб баре
class TabBarItem {
  const TabBarItem({
    required this.icon,
    required this.text,
  });

  final Icon icon;
  final String text;

  BottomNavigationBarItem build() {
    return BottomNavigationBarItem(
      icon: icon,
      label: text,
    );
  }
}
