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

### Basic use case (without Model)

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

Collect the widget tree and return it from a `build()` function the way you are used to doing it with regular *StatefulWidget*.

Every `WidgetState` has a reference to its `WidgetModel`. That's why you need to specify the concrete `WidgetModel` type as a generic type of declaring `WidgetState`.

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

Most likely, you will start your screen with a *Route*. In this case, the *Route* becomes the place where you put everything together.

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

In case your application is complex enough, you can simplify it by breaking down the business logic layer into a set of small components (*Performers*), each of which is responsible for performing a single business logic operation.

#### Create Change

**Change** is the intention to perform some action. Each operation is associated with a *Change*.

Create a *Change* by extending `FutureChange` or `StreamChange` classes.

The difference is in the type of the returned operation result. `FutureChange` will wrap the result of the operation into a `Future`, and `StreamChange` into a `Stream`.

A *Change* can also serve as a container for passing input parameters if they are needed to perform an operation. If not, you can leave the class body empty.

```dart
class LoginUser extends FutureChange<UserProfile> {
  final String login;
  final String password;
}
```

#### Create Performer

**Performer** - is a functional part of the contract. *Performer* should be responsible for the single operation. Each *Performer* is associated with *Change* one-to-one.

While declaring *Performer* you should specify two type parameters: the first is the operation result type (the same as you already set up in *Change*), the second is the associated *Change* type.

You can inject any object into the *Performer* to do necessary operations.

Create a Performer by extending `FuturePerformer` or `StreamPerformer` classes.

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

It is assumed that you already know the basic MWWM use case. If not, see [this section](#basic-use-case-without-model).

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

Finally, you can ask your *Model* to perform any operation by passing the right *Change* through the `Model.perform()` function. You just have to correctly process the result of the operation.

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

MWWM package provides built-in capabilities for handling asynchronous operations. In addition, you can take advantage of the centralized error handling mechanism.

| Function name        | Supported data type | Is default error handling mechanism enabled |
|----------------------|---------------------|---------------------------------------------|
| subscribe()            | Stream              | -                                           |
| subscribeHandleError() | Stream              | +                                           |
| doFuture()             | Future              | -                                           |
| doFutureHandleError()  | Future              | +                                           |

When using a `doFuture()` and `subscribe()`, you can pass `Future` or `Stream` respectively as the first parameter, and `onValue` function that handles the result of the asyncronous operation as the second.

`onError` parameter is optional and can be used to manually handle errors.

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

What about `doFutureHandleError()` and `subscribeHandleError()`? You can use it exactly the same way as their "no handle error" companions but with all benefits of the default error handling mechanism.

You still able to pass `onError` function but it will act as an addition to default error handling.

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

#### Default error handling customisation

You can customize the default error handling in an easy way.

First, you need to extend `ErrorHandler` class and override `handleError()` function. This function will be called whenever an error occurs. You can implement your error handling right there.

```dart
class CustomErrorHandler extends ErrorHandler {
  @override
  void handleError(Object e) {
    debugPrint('Custom error handler regretfully informs that $e has occured.');
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

Now all errors that occur during asynchronous operations launched through `doFutureHandleError()` and `subscribeHandleError()` functions will fall into a custom handler.

## FAQ

### Where should my UI layout be placed?

Directly in `WidgetState.build()` function. For those widgets that are simple enough you can use `StatelessWidget` or `StatefulWidget` from SDK.

### How can I access the widget model?

Every `WidgetState` reference its `WidgetModel` through `wm` getter. You can access it immediately after `initState()` has run.

### Where should I place the navigation?

We don't limit you in the choice of navigation approaches, but we strongly recommend to implement navigation in the **WidgetModel**.

## Recommended project structure

You decide how your project will be arranged by your own. However, we recommend you to organize your code this way:

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

