# Technical description of Flutter project template



## Technology stack

* rxDart
* http
* shared_prefs


# Creation of screen

Package of screnn include:
- *name*_screen.dart
- *name*_wm.dart
- *name*_route.dart

Classes and Widgets for screens are additionally wrapped in a one of subclasses
PageRoute<>.
This is necessary to set the animation.

Common sctructure of file with screen:
    - Widget(Stateless/Stateful)
    - WidgetState - only if widget is Stateful

