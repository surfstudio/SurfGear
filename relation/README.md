# relation

the stream representation of the relations of the entities and widget utilities

## Usage

main classes:

1. [Action](/lib/src/relation/action/action.dart)
1. [StreamedState](/lib/src/relation/state/streamed_state.dart)
1. [EntityStreamedState](/lib/src/relation/state/entity_state.dart)

# Action

#### Action

It's wrapper over an action on screen.
It may be a tap on button, text changes, focus changes and so on.

```
   SomeWidget(
     onTap: someAction.accept,
   )
    
   ...

   someAction.action.listen(doSomething);
```
 
# State

#### StreamedState

A state of some type wrapped in a stream
dictates the widget's state

```
   yourStreamedState.accept(someData);
    
   ...
   
   StreamedStateBuilder<T>(
     streamedState: yourStreamedState,
     builder: (ctx, T data) => Text(data.toString()),
   );
```
 
#### EntityStreamedState

A state that have download/error/content status

```
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