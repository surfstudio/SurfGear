# tabnavigator

Possibly the most common style of navigation in mobile apps is tab-based navigation. 
This module can manage the tabs on the screen.

## Getting Started

* Add [TabNavigator] to your widget.
* Add mapping of tabs to widgets inside the tab via [mappedTabs].
* Add a subscription to the stream of selected tabs through [selectedTabStream].
* Define a tab to be opened by default through [initialTab].
* Using [transitionsBuilder] and [transitionDuration], you can define a custom transformation to display the contents of the tab. 
