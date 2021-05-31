# Relation

[![Build Status](https://shields.io/github/workflow/status/surfstudio/SurfGear/build?logo=github&logoColor=white)](https://github.com/surfstudio/SurfGear/tree/main/packages/relation)
[![Coverage Status](https://img.shields.io/codecov/c/github/surfstudio/SurfGear?flag=relation&logo=codecov&logoColor=white)](https://codecov.io/gh/surfstudio/SurfGear)
[![Pub Version](https://img.shields.io/pub/v/relation?logo=dart&logoColor=white)](https://pub.dev/packages/relation)
[![Pub Likes](https://badgen.net/pub/likes/relation)](https://pub.dev/packages/relation)
[![Pub popularity](https://badgen.net/pub/popularity/relation)](https://pub.dev/packages/relation/score)
![Flutter Platform](https://badgen.net/pub/flutter-platform/relation)

This package is part of the [SurfGear](https://github.com/surfstudio/SurfGear) toolkit made by [Surf](https://surf.ru/).

## About

The stream representation of the relations of the entities and widget utilities

## Usage

Main classes:

1. [StreamedAction](lib/src/relation/action/streamed_action.dart)
    1.1 [ScrollOffsetAction](lib/src/relation/action/actions/scroll_action.dart)
    1.2 [TextEditingAction](lib/src/relation/action/actions/text_editing_action.dart)
2. [Builder](./lib/src/builder)
    2.1 [EntityStateBuilder](./lib/src/builder/entity_state_builder.dart)
    2.2 [StreamedStateBuilder](./lib/src/builder/streamed_state_builder.dart)
    2.3 [TextfieldStateBuilder](./lib/src/builder/textfield_state_builder.dart)
3. [StreamedState](./lib/src/relation/state/streamed_state.dart)
4. [EntityStreamedState](./lib/src/relation/state/entity_state.dart)

## Actions

### StreamedAction

It's wrapper over an action on screen.
It may be a tap on button, text changes, focus changes and so on.

```dart
   SomeWidget(
     onTap: someAction.accept,
   )
    
   ...

   someAction.action.listen(doSomething);
```

### ScrollOffsetAction

The action that fires when the value changes when scrolling.

```dart
  testWidgets(
    'ScrollOffsetAction test',
    (WidgetTester tester) async {
      final action = ScrollOffsetStreamedAction((onChanged) {
        expect(1.0, onChanged);
      });

      await tester.pumpWidget(MaterialApp(
        title: 'Flutter Demo',
        home: Scaffold(
          appBar: AppBar(
            title: Text('test'),
          ),
          body: ListView(
            controller: action.controller,
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Text('test'),
              Text('test'),
              Text('test'),
            ],
          ),
        ),
      ));

      action.controller.jumpTo(1.0);
    },
  );
```

### TextEditingStreamedAction

**Currently experimental.**  
An action that fires when a text field receives new characters

```dart
  test('TextEditingAction test', () {
    final action = TextEditingAction((onChanged) {
      expect('test', onChanged);
    });
    action.controller.text = 'test';
  });
```

## Builder

Builders are widgets that listen to a change in a stream and provide new data to child widgets

### StreamedStateBuilder

Updates child widget when an answer arrives

```dart
 testWidgets(
    'StreamedStateBuilder test',
    (WidgetTester tester) async {
      final testData = StreamedState<String>('test');
      final streamedStateBuilder = StreamedStateBuilder<String>(
          streamedState: testData,
          builder: (context, data) {
            return Text(data);
          });
      await tester.pumpWidget(
        MaterialApp(
          title: 'Flutter Demo',
          home: Scaffold(
            body: streamedStateBuilder,
          ),
        ),
      );
      final textFinder = find.text('test');
      expect(textFinder, findsOneWidget);
    },
  );
```

### EntityStateBuilder

This builder has three states onResponse, onError, onLoading

```dart
 testWidgets(
    'StreamedStateBuilder accept test',
    (WidgetTester tester) async {
      final testData = EntityStreamedState<String>(EntityState(data: 'test'));

      final streamedStateBuilder = EntityStateBuilder<String>(
        streamedState: testData,
        child: (context, data) {
          return Text(data);
        },
      );

      await tester.pumpWidget(
        MaterialApp(
          title: 'Flutter Demo',
          home: Scaffold(
            body: streamedStateBuilder,
          ),
        ),
      );
      expect(streamedStateBuilder.streamedState.value.data, 'test');
      final testFinder = find.text('test');
      expect(testFinder, findsOneWidget);

      await testData.error();
    },
  );

  testWidgets(
    'StreamedStateBuilder error test',
    (WidgetTester tester) async {
      final testData = EntityStreamedState<String>();
      final streamedStateBuilder = EntityStateBuilder<String>(
        streamedState: testData,
        child: (context, data) {
          return Text('test');
        },
        errorChild: Text('error_text'),
      );

      unawaited(testData.error(Exception()));
      await tester.pumpWidget(
        MaterialApp(
          title: 'Flutter Demo',
          home: Scaffold(
            body: streamedStateBuilder,
          ),
        ),
      );

      final errorFinder = find.text('error_text');
      expect(errorFinder, findsOneWidget);
    },
  );

  testWidgets(
    'StreamedStateBuilder loading test',
        (WidgetTester tester) async {
      final testData = EntityStreamedState<String>();
      final streamedStateBuilder = EntityStateBuilder<String>(
        streamedState: testData,
        child: (context, data) {
          return Text('test');
        },
        loadingChild: Text('loading_child'),
      );

      unawaited(testData.loading());
      await tester.pumpWidget(
        MaterialApp(
          title: 'Flutter Demo',
          home: Scaffold(
            body: streamedStateBuilder,
          ),
        ),
      );

      final loadingFinder = find.text('loading_child');
      expect(loadingFinder, findsOneWidget);
    },
  );
```

### TextFieldStateBuilder

Wrapper over TextFieldStreamedState.  
StateBuilder callback is triggered every time new data appears in the stream.

```dart
  testWidgets(
    'TextfieldStreamBuilder content test',
    (WidgetTester tester) async {
      final testData = TextFieldStreamedState('test');
      final textFieldStateBuilder = TextFieldStateBuilder(
          state: testData,
          stateBuilder: (context, data) {
            return Text('test');
          });

      await tester.pumpWidget(
        MaterialApp(
          title: 'Flutter Demo',
          home: Scaffold(
            body: textFieldStateBuilder,
          ),
        ),
      );

      final textFinder = find.text('test');
      expect(textFinder, findsOneWidget);
    },
  );
```

## State

### StreamedState

A state of some type wrapped in a stream
dictates the widget's state

```dart
   yourStreamedState.accept(someData);
    
   ...
   
   StreamedStateBuilder<T>(
     streamedState: yourStreamedState,
     builder: (ctx, T data) => Text(data.toString()),
   );
```

### EntityStreamedState

A state that have download/error/content status

```dart
 dataState.loading();
 try {
    var content = await someRepository.getData();
    dataState.content(content);
 } catch (e) {
    dataState.error(e);
 }
 
 ...

 EntityStateBuilder<Data>(
      streamedState: dataState,
      child: (data) => DataWidget(data),
      loadingChild: LoadingWidget(),
      errorChild: ErrorPlaceholder(),
    );
```

## Installation

Add `relation` to your `pubspec.yaml` file:

```yaml
dependencies:
  relation: ^3.0.0
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
