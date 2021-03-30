# relation

#### [SurfGear](https://github.com/surfstudio/SurfGear)
[![pub package](https://img.shields.io/pub/v/relation?label=relation)](https://pub.dev/packages/relation)

The stream representation of the relations of the entities and widget utilities

## Usage

Main classes:

1. [Action](./lib/src/relation/action/action.dart)  
    1.1 [ControllerAction](./lib/src/relation/action/actions/controller_action.dart)  
    1.2 [ScrollAction](./lib/src/relation/action/actions/scroll_action.dart)  
    1.2 [TextEdititingAction](./lib/src/relation/action/actions/text_editing_action.dart)
2. [Builder](./lib/src/builder)  
    2.1 [EntityStreamBuilder](./lib/src/builder/entity_stream_builder.dart)  
    2.2 [StreamedStateBuilder](./lib/src/builder/streamed_state_builder.dart)  
    2.3 [TextfieldStateBuilder](./lib/src/builder/textfield_state_builder.dart)
3. [StreamedState](./lib/src/relation/state/streamed_state.dart)
4. [EntityStreamedState](./lib/src/relation/state/entity_state.dart)

## Action

### Action

It's wrapper over an action on screen.
It may be a tap on button, text changes, focus changes and so on.

```dart
   SomeWidget(
     onTap: someAction.accept,
   )
    
   ...

   someAction.action.listen(doSomething);
```

### ControllerAction

**Currently experimental.**  
The action that fires when the value in the controller changes.

```dart
  final textEditingController = TextEditingController();
    ControllerAction(
      textEditingController,
          (TextEditingController controller, action) {
        expect(controller.runtimeType, TextEditingController);
        expect(controller.value.text, 'test');
      },
    );
    textEditingController.text = 'test';
```
 
### ScrollAction

The action that fires when the value changes when scrolling.

```dart
  testWidgets(
    'ScrollOffsetAction test',
    (WidgetTester tester) async {
      final action = ScrollOffsetAction((onChanged) {
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

### TextEditingAction

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

### EntityStreamBuilder

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
