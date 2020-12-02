# Relation
<<<<<<< HEAD

[![Build Status](https://github.com/surfstudio/SurfGear/workflows/build/badge.svg)](https://github.com/surfstudio/SurfGear)
[![Coverage Status](https://codecov.io/gh/surfstudio/SurfGear/branch/dev/graph/badge.svg?flag=relation)](https://codecov.io/gh/surfstudio/SurfGear)
[![Pub Version](https://img.shields.io/pub/v/relation)](https://pub.dev/packages/relation)
[![Pub Likes](https://badgen.net/pub/likes/relation)](https://pub.dev/packages/relation)
![Flutter Platform](https://badgen.net/pub/flutter-platform/relation)

This package is part of the [SurfGear](https://github.com/surfstudio/SurfGear) toolkit made by [Surf](https://surf.ru/).

## About

The stream representation of the relations of the entities and widget utilities

## Usage

Main classes:

1. [Action](./lib/src/relation/action/action.dart)
    1.1 [ScrollAction](./lib/src/relation/action/actions/scroll_action.dart)
    1.2 [TextEdititingAction](./lib/src/relation/action/actions/text_editing_action.dart)
2. [Builder](./lib/src/builder)
    2.1 [EntityStreamBuilder](./lib/src/builder/entity_stream_builder.dart)
    2.2 [StreamedStateBuilder](./lib/src/builder/streamed_state_builder.dart)
    2.3 [TextfieldStateBuilder](./lib/src/builder/textfield_state_builder.dart)
3. [StreamedState](./lib/src/relation/state/streamed_state.dart)
4. [EntityStreamedState](./lib/src/relation/state/entity_state.dart)

## Actions

### Action

It's wrapper over an action on screen.
=======
[![pub version](https://img.shields.io/badge/pub-0.0.2-blue)](https://pub.dev/packages/relation/versions)
This package is a part of [SurfGear](https://github.com/surfstudio/SurfGear) toolset made by [Surf](https://surf.ru/).

[![SurfGear](https://i.ibb.co/zbZ8081/Group-59.png)](https://github.com/surfstudio/SurfGear/tree/dev/packages/relation)
## About
This package provides the ability to associate user actions with application state.
## Currently supported features
- Action - It's wrapper over an action on screen.
>>>>>>> b845f14a (add new README.md)
It may be a tap on button, text changes, focus changes and so on.
- StreamedState - A state of some type wrapped in a stream
dictates the widget's state
- EntityStreamedState - A state that have download/error/content status
## Usage
### Initialization
First you need to initialize Action and StreamedState
```dart 
 final incrementAction = Action();
 final incrementState = StreamedState<int>();
 
 final reloadAction = Action();
 final loadDataState = EntityStreamedState<int>();
```
<<<<<<< HEAD

### ScrollAction

The action that fires when the value changes when scrolling.
=======
During initialization, for StreamedState and EntityStreamedState, you can set initial values that will be displayed when the widget is initialized.
```dart
final incrementState = r.StreamedState<int>(0);
final loadDataState = r.EntityStreamedState<int>(r.EntityState(isLoading: true));
```
### Action binding
After initialization, you should bind the methods that will be executed upon performing any actions
>>>>>>> b845f14a (add new README.md)

```dart
    incrementAction.stream.listen(
      (_) => increment()
    );

    reloadAction.stream.listen((_) => _load());
```
<<<<<<< HEAD

### TextEditingAction

**Currently experimental.**  
An action that fires when a text field receives new characters

=======
### State management
When a user performs an action, it entails a change in the state of the program.
>>>>>>> b845f14a (add new README.md)
```dart
Future increment() async {
    return incrementState.accept(incrementState.value + 1);
}

Future _load() async {
    await loadDataState.loading();
    var result = Future.delayed(Duration(seconds: 2),() =>DateTime.now().second,);
await loadDataState.content(await result);
}
```
- StreamedState contain any data type.
- EntityStreamedState, in addition to storing data, also contains 3 standard states
    - loading - load data 
    - error - error of load
    - data - data load success

<<<<<<< HEAD
## Builder

Builders are widgets that listen to a change in a stream and provide new data to child widgets

### StreamedStateBuilder

Updates child widget when an answer arrives
=======
These states can help you design your implementation of a responsive interface.

### Update UI
To listen for changes happening in StreamedState and EntityStreamedState use the EntityStateBuilder:
>>>>>>> b845f14a (add new README.md)

```dart
StreamedStateBuilder(
streamedState: incrementState,
builder: (ctx, count) => Text('number of count: $count'),
)
```
<<<<<<< HEAD

### EntityStreamBuilder

This builder has three states onResponse, onError, onLoading

=======
StreamedStateBuilder also supports receiving states _loading_, _error_ and _data_
>>>>>>> b845f14a (add new README.md)
```dart
EntityStateBuilder<int>(
streamedState: loadDataState,
child: (ctx, data) => Text('success load: $data'),
loadingChild: CircularProgressIndicator(),
errorChild: Text('sorry - error, try again'),
),
```
<<<<<<< HEAD

### TextFieldStateBuilder

Wrapper over TextFieldStreamedState.  
StateBuilder callback is triggered every time new data appears in the stream.

=======
## Additional States
To listen for text actions use TextEditingAction
>>>>>>> b845f14a (add new README.md)
```dart
final textAction = r.TextEditingAction();
...
textAction.stream.listen((event) {
    print("typed $event");
});
...
TextField(
    controller: textAction.controller,
    onChanged: textAction,
),
```
<<<<<<< HEAD

## State

### StreamedState

A state of some type wrapped in a stream
dictates the widget's state

=======
Use TextFieldStateBuilder to update ui
>>>>>>> b845f14a (add new README.md)
```dart
TextFieldStateBuilder(
        state: testData,
        stateBuilder: (context, data) {
        return Text('test');
}),  
```
<<<<<<< HEAD

### EntityStreamedState
=======
To track the scroll offset use ScrollOffsetAction
```dart
final scrollAction = r.ScrollOffsetAction();
...
scrollAction.stream.listen((event) {
      print("scroll offset $event");
});
...
TextField(
    controller: textAction.controller,
    onChanged: textAction,
),
...
SingleChildScrollView(
    controller: scrollAction.controller,
)
```
## Installation
```
dependencies:
  relation: ^0.0.2
```
## Changelog
All notable changes to this project will be documented in [this file](./CHANGELOG.md).
## Issues
For issues, file directly in the [main SurfGear repo](https://github.com/surfstudio/SurfGear).
## Contribute
If you would like to contribute to the package (e.g. by improving the documentation, solving a bug or adding a cool new feature), please review our [contribution guide](../../CONTRIBUTING.md) first and send us your pull request.
>>>>>>> b845f14a (add new README.md)

You PR's are always welcome.
## How to reach us

Please, feel free to ask any questions about this package. Join our community chat on Telegram. We speak English and Russian.

[![Telegram](https://img.shields.io/badge/chat-on%20Telegram-blue.svg)](https://t.me/SurfGear)

## License

<<<<<<< HEAD
## Installation

Add `relation` to your `pubspec.yaml` file:

```yaml
dependencies:
  relation: ^1.0.0
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
=======
[Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0)
>>>>>>> b845f14a (add new README.md)
