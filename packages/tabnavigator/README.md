# tabnavigator

Possibly the most common style of navigation in mobile apps is tab-based navigation. 
This module can manage the tabs on the screen.

## Getting Started

* Add [TabNavigator](lib/src/tab_navigator.dart) to your widget.
* Add mapping of tabs to widgets inside the tab via [mappedTabs](lib/src/tab_navigator.dart#L22).
* Add a subscription to the stream of selected tabs through [selectedTabStream](lib/src/tab_navigator.dart#L23).
* Define a tab to be opened by default through [initialTab](lib/src/tab_navigator.dart#L24).
* Using [transitionsBuilder](lib/src/tab_navigator.dart#L27) and [transitionDuration](lib/src/tab_navigator.dart#L28), you can define a custom transformation to display the contents of the tab. 
