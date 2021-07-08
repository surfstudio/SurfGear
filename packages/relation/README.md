# Relation

[![Build Status](https://github.com/surfstudio/SurfGear/workflows/build/badge.svg)](https://github.com/surfstudio/SurfGear)
[![Coverage Status](https://codecov.io/gh/surfstudio/SurfGear/branch/dev/graph/badge.svg?flag=relation)](https://codecov.io/gh/surfstudio/SurfGear)
[![Pub Version](https://img.shields.io/pub/v/relation)](https://pub.dev/packages/relation)
[![Pub Likes](https://badgen.net/pub/likes/relation)](https://pub.dev/packages/relation)
![Flutter Platform](https://badgen.net/pub/flutter-platform/relation)

This package is part of the [SurfGear](https://github.com/surfstudio/SurfGear) toolkit made by [Surf](https://surf.ru/).

![Relation Cover](https://i.ibb.co/f1yC8d5/relation-logo.png)

## About

Two-way communication channels for transferring data between different architectural layers of a Flutter application.

## Currently supported features

- Notify your app's presentation layer about every user input or UI event (button tap, focus change, gesture detection, etc.) using `StreamedAction` and implement a reaction to them;
- Write less code with *StreamedAction* that are customized for specific user cases (scrolling, editing text, `ValueNotifier` value changing).
- React to the data state changes and redraw UI using `StreamedState` together with `StreamedStateBuilder` and its variations;
- Manage the screen state easily with a special stream that handles three predefined states: data, loading, error.

## Usage

### Notify and react

#### StreamedAction

![StreamedAction Scheme](https://i.ibb.co/6wVgh84/relation-action.png)

`StreamedAction` is a good way to notify consumers about every event coming from the UI.

Create an `StreamedAction` class instance. You can pass data with `StreamedAction`'s events, so you need to specify the concrete type of `StreamedAction` while declaring it.

```dart
final logoutAction = VoidAction();

final addItemToCartAction = StreamedAction<Item>();
```

Find the place where you're going to handle events triggered by your `StreamedAction`. Subscribe to the event stream. You can access it through the `stream` property.

```dart
logoutAction.stream.listen(
  (_) => logout()
);

addItemToCartAction.stream.listen(
  (item) => addItemToCart(item)
);
```

Now you can trigger an event through an `StreamedAction` instance from anywhere just like that:

```dart
logoutAction.accept();

addItemToCartAction.accept(item);
```

Or even easier:

```dart
TextButton(
  onPressed: logoutAction,
  ...
),
```

#### StreamedState

![StreamedState Scheme](https://i.ibb.co/nwZWsP2/relation-streamed-state.png)

With `StreamedState` you can notify consumers of data changes.

Create a `StreamedState` class instance. `StreamedState` constructor allows you to set the initial value that the consumers will receive as soon as they subscribe to the `StreamedState`. You need to specify the data type that your `StreamedState` will handle.

```dart
final userBalanceState = StreamedState<int>(0);

final itemsInCartState = StreamedState<List<Item>>();
```

You can subscribe to `StreamedState` changes the same way as with `Action`.

```dart
userBalanceState.stream.listen(
  (balance) => showUserBalance(balance)
);
```

To notify consumers of any data changes, you can release the relevant data to the `StreamedState` via the `accept()` function.

```dart
userBalanceState.accept(100);
```

In fact, you can use `Action`s and `StreamedState`s to communicate between any objects in your application. However, we recommend using them to connect the UI and presentation layers.

### Update UI

#### StreamStateBuilder

![StreamedStateBuilder Scheme](https://i.ibb.co/xhVBkt8/relation-streamed-state-builder.png)

`StreamStateBuilder` is a widget built on the latest snapshot of interaction with a `StreamedState`. The `StreamStateBuilder`'s behavior is almost the same as the standard `StreamBuilder`. The only difference is that it accepts `StreamedState` instead of the usual `Stream`, thus simplifying the initial data setup.

`StreamStateBuilder` rebuilds its widget subtree each time as its corresponding `StreamedState` emits a new value. This is the recommended way to organize your UI layer. It can save you from multiple `setState()` function calls.

```dart
Container(
  child: StreamedStateBuilder(
    streamedState: userBalanceState,
    builder: (ctx, balance) => _buildUserBalanceWidget(balance),
  ),
)
```

### State Management

![State Management Scheme](https://i.ibb.co/YcnGww0/relation-state-management.png)

You can build a state management solution for your Flutter app using all of the components above.

We recommend using **Relation** package in conjunction with [MWWM architecture](https://pub.dev/packages/mwwm).

- Use `StreamedAction` to notify the presentation layer of all UI events (button taps, pull-to-refresh triggers, swipes, or other gestures detections);
- Use `StreamedState` to report any data changes to the UI layer;
- Let `StreamedStateBuilder` manage the UI state for you. It will rebuild all its child widgets right after it detects any newly released data in the associated `StreamedState`.

## Extra units

The **Relation** package provides you not only with some basic components for common use cases, but with even more highly specialized classes for solving specific issues.

### Extra StreamedActions

#### ScrollOffsetActon

You can use special `ScrollOffsetAction` to track the scroll offset of a scrollable widget. This is possible thanks to the built-in `ScrollController`.

```dart
final scrollOffsetAction = ScrollOffsetAction();

scrollOffsetAction.stream.listen((offset) {
  print("Current scroll offset = $offset");
});

SingleChildScrollView(
  controller: scrollOffsetAction.controller,
)
```

#### TextEditingActon

`TextEditingAction` is a special type of **Action** that tracks text changes in the text field. The built-in `TextEditingController` makes it possible.

```dart
final textEditingAction = TextEditingAction();

textEditingAction.stream.listen((text) {
    print("Typed text = $text");
});

TextField(
    controller: textEditingAction.controller,
    onChanged: textEditingAction,
),
```

#### ControllerActon

`ControllerAction` is more common than the two previous variations. You can pass a [`ValueNotifier`](https://api.flutter.dev/flutter/foundation/ValueNotifier-class.html) inheritor during the `ControllerAction` instantiation.

This means you can work with the `ClipboardStatusNotifier`, `TextEditingController` or `TransformationController` through the `ControllerAction`.

### Extra StreamedStates

#### EntityStreamedState + EntityStateBuilder

`EntityStreamedState` is an extended version of `StreamedState` designed to make implementing typical dynamic data screens easier.

Most screens in mobile applications are quite simple and usually have several typical states:

- data;
- loading;
- error.

`EntityStreamedState` provides you with a convenient interface for the data stream to handle these states properly.

Create a `EntityStreamedState` class instance. It has the same abilities as `StreamedState`: the initial value setup and the specific data type declaration. Keep in mind that `EntityStreamedState` accepts an `EntityState` wrapper around your data rather than a raw part of your data.

```dart
final userProfileState = EntityStreamedState<UserProfile>(EntityState(isLoading: true));
```

Now you can switch your `EntityStreamedState`'s state with just a simple function call. A typical workflow for a query providing some data would look like this:

```dart
userProfileState.loading();
try {
  final result = await _loadUserProfile();
  userProfileState.content(result);
} on Exception catch (error) {
  userProfileState.error(error);
}
```

But what do all these functions actually do? The answer is on the other side. By using `EntityStateBuilder` instead of just `StreamedStateBuilder` you can set widgets for all three states and switch between them easily.

Pass `EntityStreamedState` instance to the `streamedState` argument first. After that, you can specify a set of widgets for displaying data (`child`), load state (`loadingChild`), and error state (`errorChild`).

```dart
EntityStateBuilder<UserProfile>(
  streamedState: userProfileState,
  builder: (ctx, data) => UserProfileWidget(data),
  loadingChild: CircularProgressIndicator(),
  errorChild: ErrorWidget('Something went wrong. Please, try again'),
),
```

Another way to deal with `EntityStateBuilder` is to use `loadingBuilder` and `errorBuilder`. This allows you to customize the error state widgets because you can account for the type of error and the last registered data value from the data stream received by the `errorBuilder`. The same with `loadingBuilder`.

```dart
EntityStateBuilder<UserProfile>(
  streamedState: userProfileState,
  builder: (ctx, data) => UserProfileWidget(data),
  loadingBuilder: (context, data) {
    return LoadingWidget(data);
  },
  errorBuilder: (context, data, error) {
    return ErrorWidget(error);
  },
),
```

To summarize, every time someone calls an `EntityStateBuilder`'s functions (`loading()`, `content()` or `error()`), the builder redraws its widget subtree and displays the state that corresponds to the last call.

#### TextFieldStreamedState + TextFieldStateBuilder

The idea behind `TextFieldStreamedState` and `TextFieldStateBuilder` is technically the same. The only difference is that `TextFieldStreamedState` is designed to work with text widgets (`Text`, `TextField`, etc.).

`TextFieldStreamedState` allows you to set up your text field validation rules and some other settings, such as making the text field mandatory for the user to fill out.

```dart
final textState = TextFieldStreamedState(
  'initialString',
  validator: '[a-zA-Z]{3,30}',
  canEdit: true,
  incorrectTextMsg: 'Text is invalid',
  mandatory: true,
);
```

`TextFieldStateBuilder` accepts the `TextFieldStreamedState` instance and allows to create text widgets according to all state properties.

```dart
TextFieldStateBuilder(
  state: textState,
  stateBuilder: (context, textStateValue) {
    return Text(textStateValue.data);
  },
),
```

## Installation

Add `relation` to your `pubspec.yaml` file:

```yaml
dependencies:
  relation: ^2.0.0
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