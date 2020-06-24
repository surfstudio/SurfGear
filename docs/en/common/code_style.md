[Main](../main.md)

# Code style

## Key Points

This document describes code style conventions. We are following the recommendations
described in [Effective Dart](https://www.dartlang.org/guides/language/effective-dart)
and before starting development, we strongly recommend that you familiarize yourself with them.

Before each pull request, you must format the code with dartfmt
(Ctrl + Alt + L for Android Studio, Ctrl + Alt + F for VS Code, the plugin for Flutter must be installed).

## Documentation, сomments

discribed in [Docs](https://www.dartlang.org/guides/language/effective-dart/documentation)

## Names

### file names

Files are named in **snake_case**.

Files of the main components of the screen should end with the following suffixes:

- *screen* — file with screen widget

- *wm* — file with screens's WidgetModel

- *route* - file with screens's Route

### Resource naming

Resources (strings, asset file names) are declared using the const modifier,
so that in widget constructor they can be used as the default value.

### Naming variables and methods

 Constants are named in lowerCamelCase (as written in [Effective Dart](https://dart.dev/guides/language/effective-dart/style#prefer-using-lowercamelcase-for-constant-names)):
```dart
    const String keyAlias = "KEY_ALIAS"
```

 Boolean variables must begin with the auxiliary verbs is / was / has.
 
he following suffixes exist for widget and model widgets fields:

   - *State* — StreamedState class entity
   
   - *Action* — Action class entity
   
   - *Controller* — various controllers (AnimationController, TextEditingController, etc.)
   
 The names of methods and functions must contain a verb that reflects the logic being executed. ** And / Or ** unions in method names should be avoided.(They are triggers for refactoring)
 
 or named methods, the following prefixes are recommended:
 
 - *build* — for methods that return part of the widget tree (used to simplify layout)
 
 - *reload* — data loading/reloading methods
 
### Class naming

Should use the following postfixes for entities:

- *Widget/Screen* — separate widget or layout of the whole screen

- *WidgetModel* — widget model

- *Component* — component for configuring dependencies

- *Interactor* — business logic interactors

- *Repository* — repositories

## Code organization

### File structure

Dart allows you to store several classes in one file, therefore it is recommended to combine several classes that are related in functionality into a single file.

A typical file and folder file structure is described [here](./structure.md).

Additionally:

  - The screen directory should contain a di-component settings folder
  
  - Global functions should be collected in utils suffix files
    
### Class structure

Inside the class, use the following order method and fields:
1. static const fields

1. static fields

1. final fields

1. private fields (get/set)

1. public fields (get/set)

1. consctructors

1. @override

1. public methods (static too)

1. @protected methods

1. private methods

## Formatting

**IMPORTANT**: For better readability, it is recommended to insert a comma after the last argument in calls of methods and constructors, as well as in the description of their parameters, if they do not fit on the same line (trailing comma).

Bad:
```dart
  func(
      "foobar",
      "barfoo",
      "asdf1234",
      "orange",
      "apple",
      "banana",
      "foobar",
      "barfoo",
      "asdf1234",
      "orange",
      "apple",
      "banana");
```
Good:
```dart
  func(
      "foobar",
      "barfoo",
      "asdf1234",
      "orange",
      "apple",
      "banana",
      "foobar",
      "barfoo",
      "asdf1234",
      "orange",
      "apple",
      "banana", //This is trailing comma
  );
```


## Recommendations

When developing, you should use the rules and approaches described [here](https://www.dartlang.org/guides/language/effective-dart/design)


