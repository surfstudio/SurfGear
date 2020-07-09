# TabNavigator

[Main](../main.md)
[Navigation](./navigation.md)

In addition to the usual transitions between tabs, sometimes you need to implement nested navigation.
Each tab is required to have its own navigation stack. 
This is necessary so that the user does not lose navigation history when switching tabs.

To solve this problem, TabNavigator was developed.

# Principle of work

When initializing TabNavigator, you need to add Map if screens 
on which you need to implement nested navigation. 
Selected screens are wrapped in a list of navigators that sequentially follow each other. 
Thus, nested navigation is implemented.

When adding a widget to TabNavigator, the "parent" buildContext is passed to it. 
So, when you need to switch to a new screen from a nested widget, 
you need to call the ```dart TabNavigatorState of(BuildContext context)``` method. 
It returns the state of the navigator, which is used in the root context.
Thanks to this mechanism, from the embedded screen you can
which is outside the current nesting chain.

TabNavigator can be combined with any graphic component. For example, BottomNavigation.

For determining the index of the opened tab, Stream\<TabType\> selectedTabStream is responsible.
To track information about an open tab, you must use ObserversBuilder.