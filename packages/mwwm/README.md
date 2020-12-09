# mwwm

[![Pub Version](https://img.shields.io/pub/v/mwwm)](https://pub.dev/packages/mwwm)
[![Pub Version (including pre-releases)](https://img.shields.io/pub/v/mwwm?include_prereleases)](https://pub.dev/packages/mwwm)
[![Pub Likes](https://badgen.net/pub/likes/mwwm)](https://pub.dev/packages/mwwm)

This package is a part of [SurfGear](https://github.com/surfstudio/SurfGear) toolset made by [Surf](https://surf.ru/).

![MWWM Cover](https://i.ibb.co/BZ1WCF5/logo-mwwm-black.png)

## About

MVVM-inspired lightweight architectural framework for Flutter apps with respect to Clean Architecture.

## Currently supported features

- Complete separation of the application's codebase into independent logical layers: *UI*, *presentation* and *business logic*;
- Widget tree remains crystal clear: the main building block is just an extended version of StatefulWidget;
- Built-in mechanisms for handling asynchronous operations with the default error handling strategy support;
- Event-like mechanism that helps to keep business logic well structured and testable.

## Overview

MWWM is a perfect mix of the [Flutter framework architectural concept](https://flutter.dev/docs/resources/architectural-overview), pretty clear [MVVM](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93viewmodel) pattern, as well as the [Clean Architecture principles](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html).

### MWWM's superpowers

- **Simple** - no crazy complex abstractions that change the structure of your project beyond recognition;

- **Flexible** - you can restrict the scope of MWWM components usage only to a certain project area (screen or widget). You still can use `StatefulWidget` and `StatelessWidget` anywhere you don't want to overcomplicate;

- **Scalable** - the complexity and scale of your project is not a problem. You can use additional MWWM features as the complexity of your project grows (such as `Model`);

- **Not limited** - this architecture package doesn't dictate you what DI, navigation or any other approaches you should use in your project. You can even implement communication between layers the way you want (or you can do it with another package to follow our reccomendations). Everything is up to you!

### Key components

![MWWM logical layers scheme](https://github.com/surfstudio/mwwm/blob/dev/doc/images/mwwm.png?raw=true)

#### Widget

This is where your declarative layouts live. Components of this layer contain UI related code only and act like typical `StatefulWidget`. Widget holds a link to its widget model.

Presented by `CoreMwwmWidget` class.

#### WidgetModel

`WidgetModel` is like a back side of your widget. Its concept is very similar to `State` with one big difference. `State` knows nothing about the business logic of your application and can't even reference any business-logic components, but `WidgetModel` does.

- It holds the current state of the widget, which can be meaningful for business logic scenarios;
- It knows which user input (or any other UI event) should trigger which business logic scenarios and acts like a dispatcher between them.

Presented by `WidgetModel` class.

#### Model

Unlike other components, the `Model` is optional.

`Model` is a great way to reduce complexity of the business logic layer of your application by separating it between two sets of abstractions:
- `Change` - is an intent to do something without any concrete implementation details, there can only be input parameters;
- `Performer` - is a reaction to the associated `Сhange`, containing an implementation of some operation.

Presented by `Model`, `Change` and `Performer` classes.

## Usage

###  Create Widget and WidgetModel

Create a `WidgetModel` class by extending [WidgetModel].

```dart
class RepositorySearchWm extends WidgetModel {

  RepositorySearchWm(
    WidgetModelDependencies baseDependencies, //1
    ) : super(baseDependencies);

}
``` 

1 - [WidgetModelDependencies](./lib/src/dependencies/wm_dependencies.dart) is a bundle of required dependencies. Default there is [ErrorHandler](./lib/src/error/error_handler.dart), which 
give possibility to place error handling logic in one place. You must provide an implementation of handler.



Add Widget simply by creating StatefulWidget and replace parent class with [CoreMwwmWidget](./lib/src/widget_state.dart)

```dart
class RepositorySearchScreen extends CoreMwwmWidget {

  //...

  @override
  State<StatefulWidget> createState() {
    return _RepositorySearchScreenState();
  }
}
```

By **convention** create a same constructor:
```dart
  RepositorySearchScreen({
    WidgetModelBuilder wmBuilder, // need to testing
  }) : super(
          widgetModelBuilder: wmBuilder ??
              (ctx) => RepositorySearchWm(
                    // provide args,
                  ),
        );
```
or by route:
```dart
  class RepositorySearchRoute extends MaterialPageRoute {
    RepositorySearchRoute()
        : super(
            builder: (context) => RepositorySearchScreen(
              widgetModelBuilder: _buildWm,
            ),
          );
  }

  WidgetModel _buildWm(BuildContext context) => RepositorySearchWm(
        context.read<WidgetModelDependencies>(), // this example based on Provider
      );
```

Change parent of `State` of `StatefulWidget` to [WidgetState](./lib/src/widget_state.dart):
```dart
class _RepositorySearchScreenState extends WidgetState<RepositorySearchWm>
```

All done! You create your presentation layer.

### Creating Model layer

This package give you optional possibility to use a `Model`  - a facade over business logic and service layer of your app.

To use Model you must:

1. Create a `Change` - an intention to do something on service layer. Change can has data. Formally, it is an arguments of some function. It is like Event in Bloc.
```dart
class GetData extends FutureChange<String> {
  //...
  // there can be some data
}
```

2. Create a `Performer` - is a functional part of this contract. It is so close to UseCase. Performer, in ideal world, do only one thing. It is small part og logic which needed to perform Change.
```dart
class GetDataPerformer extends FuturePerformer<String, GetData> { 

  @override
  Future<String> perform(GetData change) {
    //...
  }
}
```
3. Provide a `Model` to your `WidgetModel`. 

```dart
class RepositorySearchWm extends WidgetModel {

  RepositorySearchWm(
    WidgetModelDependencies baseDependencies,
    Model model, //1
    ) : super(baseDependencies, model: model); //2

}
``` 
1 - Add model as param to constructor;
2 - provide model to superclass.

```dart
  WidgetModel _buildWm(BuildContext context) => RepositorySearchWm(
        context.read<WidgetModelDependencies>(), 
        Model([
          GetDataPerformer(), // 1
        ]),
      );
```
1 - create model instance and provide a list with performers, in this case with `GetDataPerformer`.

4. Call model from your WM.
```dart
class RepositorySearchWm extends WidgetModel {
//...
  void doSomething() {
    doFuture(model.perform(GetData()),
      onValue: (data){
        print(data);
      }
    );
  }
}
```

That's all folks!

## FAQ

### Where can I place UI?

Simply in **build** method in `WidgetState`. No difference with Flutter framework.

### How can I obtain a WM?

`WidgetState` has `WidgetModel` after `initState()` called.
There is a getter - **wm** - to get your `WidgetModel` in your Widget.

### Where should I place navigation logic?

Only in **WidgetModel**. But we don't hardcodea way to do this, yet.

## Recommended file structure

We recomend following structure:

- ./
  - data/
  - model/
    - services(repository)/
    - changes.dart  // can split
    - performer.dart // can split
  - ui/
    - screen(widget)/
      - wm.dart
      - route.dart
      - screen(widget).dart  
      
      
## Installation

Add mwwm to your `pubspec.yaml` file:

```yaml
dependencies:
  mwwm: version
```

## Changelog

All notable changes to this project will be documented in [this file](./CHANGELOG.md).

## Issues
For issues, file directly in the [main SurfGear repo](https://github.com/surfstudio/SurfGear).

## Contribute
If you would like to contribute to the package (e.g. by improving the documentation, solving a bug or adding a cool new feature), please review our [contribution guide](../../CONTRIBUTING.md) first and send us your pull request.

You PR's are always welcome.
## How to reach us

Please, feel free to ask any questions about this package. Join our community chat on Telegram. We speak English and Russian.

[![Telegram](https://img.shields.io/badge/chat-on%20Telegram-blue.svg)](https://t.me/SurfGear)

## License

[Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0)

