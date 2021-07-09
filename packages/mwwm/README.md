# MWWM

[![Build Status](https://shields.io/github/workflow/status/surfstudio/SurfGear/build?logo=github&logoColor=white)](https://github.com/surfstudio/SurfGear/tree/main/packages/mwwm)
[![Coverage Status](https://img.shields.io/codecov/c/github/surfstudio/SurfGear?flag=mwwm&logo=codecov&logoColor=white)](https://codecov.io/gh/surfstudio/SurfGear)
[![Pub Version](https://img.shields.io/pub/v/mwwm?logo=dart&logoColor=white)](https://pub.dev/packages/mwwm)
[![Pub Likes](https://badgen.net/pub/likes/mwwm)](https://pub.dev/packages/mwwm)
[![Pub popularity](https://badgen.net/pub/popularity/mwwm)](https://pub.dev/packages/mwwm/score)
![Flutter Platform](https://badgen.net/pub/flutter-platform/mwwm)

This package is part of the [SurfGear](https://github.com/surfstudio/SurfGear) toolkit made by [Surf](https://surf.ru/).

![MWWM Cover](https://i.ibb.co/9qBTf3S/Bunner-LOGO.png)

## About

MVVM-inspired lightweight architectural framework for Flutter apps made with respect to Clean Architecture.

## Currently supported features

- Complete separation of the application's codebase into independent layers: *UI*, *presentation* and *business logic*;
- Keeps widget tree clear: the main building block is just an extended version of StatefulWidget;
- Built-in mechanisms for handling asynchronous operations;
- The ability to easily implement the default error handling strategy;
- An event-like mechanism that helps keep the business logic well structured and testable.

## Overview

MWWM is the perfect mix of the [Flutter framework architectural concept](https://flutter.dev/docs/resources/architectural-overview), the simple [MVVM](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93viewmodel) pattern, and the [Clean Architecture principles](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html).

### MWWM's superpowers

- **Simple** - no crazy complex abstractions that change the structure of your project beyond recognition;

- **Flexible** - you can apply MWWM components to a certain project area (screen or widget). You still can use `StatefulWidget` and `StatelessWidget` wherever you would like to keep things simple;

- **Scalable** - the scale of your project is not a problem. You can use additional MWWM features as your project grows more complex (such as `Model`);

- **No limitations** - this architecture package doesn't dictate what DI, navigation, or any other approaches you should use in your project. You can even implement communication between layers the way you want. Or take our advice and do so with the [Relation package](https://pub.dev/packages/relation). Everything is up to you!

### Key components

![MWWM Architecture Scheme](https://i.ibb.co/Y778rtM/Key-components.png)

#### Widget

This is where your declarative layouts live. Components of this layer contain UI-related code only and act like typical `StatefulWidget`. The Widget contains the link to its widget model.

Presented by `CoreMwwmWidget` class.

#### WidgetModel

`WidgetModel` is like the mechanism behind your widget. Its concept is very similar to `State` but there is one big difference. `State` knows nothing about the business logic of your app and can't refer to any business logic components, while `WidgetModel` can.

- It tells the current state of the widget, which can be meaningful for business logic scenarios;
- It knows which user input (or any other UI event) triggers a certain business logic scenario and acts as a dispatcher between them.

Presented by the `WidgetModel` class.

#### Model

Unlike other components, the `Model` is optional.

`Model` is a great way to simplify the business logic layer of your app by breaking it into two sets of abstractions:

- `Change` is an intent to do something without any concrete implementation details, only input parameters;
- `Performer` is the reaction to the `Change` that is associated with it. The Performer contains the implementation of a certain operation that is triggered by the Change.

Presented by the `Model`, `Change`, and `Performer` classes.

## Usage

### Basic use case (without Model)

![MWWM Architecture Mini Scheme](https://i.ibb.co/qN4z81w/arch-scheme-min.png)

#### Create WidgetModel

Create a WidgetModel for the widget by extending the `WidgetModel` class.

If you want certain part of your code to run as soon as the widget is initialized, you can override the `onLoad()` function and place this code right after the super-function invocation.

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

You need to create an instance of the `WidgetModel`. We recommend using top-level functions for this.

Don't forget to pass `WidgetModelDependencies` as the first argument. Use it as a bundle that contains a set of dependencies required for all WidgetModels in your app (e.g. error handlers, loggers).

```dart
WidgetModel buildLoginWM(BuildContext context) => 
  LoginWm(
    WidgetModelDependencies(),
  );
}
```

#### Create Widget

Create a Widget by extending the `CoreMwwmWidget` class.

```dart
class LoginScreen extends CoreMwwmWidget {

  LoginScreen({
    WidgetModelBuilder widgetModelBuilder,
  })  : assert(widgetModelBuilder != null),
        super(widgetModelBuilder: widgetModelBuilder);

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}
```

#### Create WidgetState

`CoreMwwmWidget` is an extended version of `StatefulWidget`. We need to attach a State for it by extending `WidgetState` class.

Collect the widget tree and return it from a `build()` function the way you usually do it with regular *StatefulWidget*.

Every `WidgetState` refers to its `WidgetModel`. That's why you need to specify the concrete `WidgetModel` type as a generic type of the `WidgetState`.

```dart
class _LoginScreenState extends WidgetState<LoginWm> {

  @override
  Widget build(BuildContext context) => 
    Scaffold(
      body: Container(), 
    );
}
```

#### Create entry point

You will most likely start your screen with a *Route*. In this case, the *Route* becomes the place where you put everything together.

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

### Advanced use case (with Model)

In case your app is too complicated, you can simplify it by breaking down the business logic layer into a set of smaller components (*Performers*), each responsible for performing a single business logic operation.

#### Create Change

**Change** is the intention to perform an action. Each operation is associated with a *Change*.

Create a *Change* by extending `FutureChange` or `StreamChange` classes.

The difference between them is the type of the returned operation result. `FutureChange` will wrap the result into a `Future`, and `StreamChange` into a `Stream`.

A *Change* can also serve to contain passing input parameters if they are needed to perform an operation. If not, leave the class body empty.

```dart
class LoginUser extends FutureChange<UserProfile> {
  final String login;
  final String password;
}
```

#### Create Performer

**Performer** - is a functional part of the contract. *Performer* should be responsible for no more than one operation. Each *Performer* is associated with *Change* one-to-one.

While declaring *Performer* you should specify two types of parameters: the first is the operation result type (the same as you already set up in *Change*), the second is the associated *Change* type.

You can insert any object into the *Performer* to launch any necessary operations.

Create a Performer by extending the `FuturePerformer` or `StreamPerformer` classes.

```dart
class LoginUserPerformer extends FuturePerformer<UserProfile, LoginUser> {

  final AuthService authService;

  @override
  Future<UserProfile> perform(LoginUser change) {
    // api call retrieving user profile instance
    return userProfile;
  }
}
```

#### Pass configured Model to WidgetModel

You probably already know the basic MWWM use case. If not, see [this section](#basic-use-case-without-model).

Declare `Model` instance as an argument for your *WidgetModel* constructor and pass it to its super-constructor.

```dart
class LoginWm extends WidgetModel {

  LoginWm(
    WidgetModelDependencies baseDependencies,
    Model model,
    ) : super(baseDependencies, model: model);
}
```

Go back to the top-level function that creates *WidgetModel*. Pass the newly created *Model* instance to the *WidgetModel's* constructor.

Remember to pass an array containing all the *Performers* that can be accessed through this *WidgetModel* to the *Model's* constructor.

```dart
WidgetModel buildLoginWM(BuildContext context) => 
  LoginWm(
    WidgetModelDependencies(),
    Model([
      LoginUserPerformer(),
    ]),
  );
}
```

#### Perform the operation

Finally, you can request your *Model* to perform any operation by passing the right *Change* through the `Model.perform()` function. You just have to correctly process the result of the operation.

```dart
class LoginWm extends WidgetModel {

  void performUserLogin() async {
    final userProfile = await model.perform(LoginUser(login, password);,
    ...
  }
}
```

That's all folks! You are now familiar with the advanced technique of using MWWM-architecture.

### Asynchronous operations handling

MWWM package provides built-in capabilities for asynchronous operations. In addition, you can take advantage of the centralized error handling function.

| Function name        | Supported data type | Is default error handling mechanism enabled |
|----------------------|---------------------|---------------------------------------------|
| subscribe()            | Stream              | -                                           |
| subscribeHandleError() | Stream              | +                                           |
| doFuture()             | Future              | -                                           |
| doFutureHandleError()  | Future              | +                                           |

When using `doFuture()` and `subscribe()`, select `Future` or `Stream` as the first parameter. The `onValue` function handles the result of the asynchronous operation as the second.

The `onError` parameter is optional and can be used to handle errors manually.

```dart
doFuture<bool>(
  isAuthenticated(),
  (isAuth) {
    if (isAuth)
      navigator.push(MainScreenRoute());
  },
  onError: (error) {
    print(error);
  },
);
```

What about `doFutureHandleError()` and `subscribeHandleError()`? You can use them the same exact way as their "no handle error" companions, with all the benefits of the default error handling mechanism.

You can still use the `onError` function to pass but it will now act as an addition to default error handling.

```dart
doFutureHandleError<bool>(
  login(),
  (isLogin) {
    if (isLogin)
      navigator.push(MainScreenRoute());
  },
  onError: (error) {
    print(error);
  },
);
```

#### Default error handling customization

Error handling is easily customizable.

First, extend the `ErrorHandler` class and override the `handleError()` function. This function will be used whenever an error occurs. You can implement your error handling right there.

```dart
class CustomErrorHandler extends ErrorHandler {
  @override
  void handleError(Object e) {
    debugPrint('Custom error handler regretfully informs that $e has occurred.');
  }
}
```

Follow the top-level function that creates WidgetModel. Pass your custom error handler instance as errorHandler argument value. That's it.

```dart
WidgetModel buildLoginWM(BuildContext context) => 
  LoginWm(
    WidgetModelDependencies(
      errorHandler: LoginScreenErrorHandler(),
    ),    
  );
}
```

Now all errors that occur during asynchronous operations launched by the `doFutureHandleError()` and `subscribeHandleError()` functions will fall into a custom handler.

## FAQ

### Where should my UI layout be placed?

Directly in the `WidgetState.build()` function. For widgets that are simple use `StatelessWidget` or `StatefulWidget` from SDK.

### How can I access the widget model?

Every `WidgetState` reference its `WidgetModel` through `wm` getter. You can access it immediately after running `initState()`.

### Where should I place the navigation?

We don't limit you in the choice of navigation approaches, but we strongly recommend implementing navigation in the **WidgetModel**.

## Recommended project structure

You decide how your project will be arranged. However, we recommend you organize your code this way:

- /lib
  - model/
    - feature1/
      - services
      - changes.dart
      - performer.dart
    - feature2/
      - services
      - changes.dart
      - performer.dart
  - ui/
    - screen1/
      - wm.dart
      - widget.dart  
      - route.dart
    - screen2/
      - wm.dart
      - widget.dart  
      - route.dart

## Installation

Add mwwm to your `pubspec.yaml` file:

```yaml
dependencies:
  mwwm: ^1.0.0
```

You can use both `stable` and `dev` versions of the package listed above in the badges bar.

## Changelog

All notable changes to this project will be documented in [this file](./CHANGELOG.md).

## Issues

For issues, file directly in the [main SurfGear repo](https://github.com/surfstudio/SurfGear).

## Contribute

If you would like to contribute to the package (e.g. by improving the documentation, solving a bug or adding a cool new feature), please review our [contribution guide](../../CONTRIBUTING.md) first and send us your pull request.

Your PRs are always welcome.

## How to reach us

Please feel free to ask any questions about this package. Join our community chat on Telegram. We speak English and Russian.

[![Telegram](https://img.shields.io/badge/chat-on%20Telegram-blue.svg)](https://t.me/SurfGear)

## License

[Apache License, Version 2.0](https://www.apache.org/licenses/LICENSE-2.0)
