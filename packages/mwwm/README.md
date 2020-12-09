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

- **Scalable** - the complexity and scale of your project are not a problem. You can use additional MWWM features as the complexity of your project grows (such as `Model`);

- **Not limited** - this architecture package doesn't dictate to you what DI, navigation, or any other approaches you should use in your project. You can even implement communication between layers the way you want (or you can do it with another package to follow our recommendations). Everything is up to you!

### Key components

![MWWM logical layers scheme](https://github.com/surfstudio/mwwm/blob/dev/doc/images/mwwm.png?raw=true)

#### Widget

This is where your declarative layouts live. Components of this layer contain UI related code only and act like typical `StatefulWidget`. Widget holds a link to its widget model.

Presented by `CoreMwwmWidget` class.

#### WidgetModel

`WidgetModel` is like the backside of your widget. Its concept is very similar to `State` with one big difference. `State` knows nothing about the business logic of your application and can't even reference any business-logic components, but `WidgetModel` does.

- It holds the current state of the widget, which can be meaningful for business logic scenarios;
- It knows which user input (or any other UI event) should trigger which business logic scenarios and acts as a dispatcher between them.

Presented by `WidgetModel` class.

#### Model

Unlike other components, the `Model` is optional.

`Model` is a great way to reduce the complexity of the business logic layer of your application by separating it between two sets of abstractions:
- `Change` - is an intent to do something without any concrete implementation details, there can only be input parameters;
- `Performer` - is a reaction to the associated `Сhange`, containing an implementation of some operation.

Presented by `Model`, `Change` and `Performer` classes.

## Usage

### Basic use case (without `Model`)

#### Create WidgetModel

Create a WidgetModel for the widget by extending the `WidgetModel` class.

If you want some piece of code to run as soon as the widget will be initialized, you can override `onLoad()` function and place this code right after the super-function invocation.

```dart
class LoginWm extends WidgetModel {

  LoginWm(
    WidgetModelDependencies baseDependencies,
  ) : super(baseDependencies);

  @override
  void onLoad() {
    super.onLoad();
    ...
  }
}
``` 

#### Implement WidgetModel builder

You need to create an instance of the `WidgetModel`. We recommend using the top-level functions for this.

Don't forget to pass `WidgetModelDependencies` as the first argument. Use it as a bundle that contains a set of dependencies required for all WidgetModels in your app (e.g. error handlers, loggers).

```dart
WidgetModel buildLoginWM(BuildContext context) => 
  LoginWm(
    WidgetModelDependencies(),
  );
}
``` 

#### Create Widget

Create a Widget by extending `CoreMwwmWidget` class.

```dart
class LoginScreen extends CoreMwwmWidget {

  LoginScreen({
    @required WidgetModelBuilder widgetModelBuilder,
  })  : assert(widgetModelBuilder != null),
        super(widgetModelBuilder: widgetModelBuilder);

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}
```

#### Create WidgetState

`CoreMwwmWidget` is an extended version of `StatefulWidget`. So, we need to declare State for it by extending `WidgetState` class.

Collect the widget tree and return it from a `build()` function the way you are used to doing it with regular `StatefulWidget`.

Every `WidgetState` has a reference to its `WidgetModel`. That's why you need to specify the concrete `WidgetModel` type as a generic type of declaring `WidgetState`.

```dart
class _LoginScreenState extends WidgetState<LoginWm> {

  @override
  Widget build(BuildContext context) => 
    Scaffold(
      body: ... 
    );
}
```

#### Create entry point

Most likely, you will start your screen with a `Route`. In this case, the `Route` becomes the place where you put everything together.

```dart
  class LoginScreenRoute extends MaterialPageRoute {
    LoginScreenRoute()
        : super(
            builder: (context) => LoginScreen(
              widgetModelBuilder: buildLoginWM(),
            ),
          );
  }
```

That's it! Now you can implement your first MWWM-powered screen.

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

