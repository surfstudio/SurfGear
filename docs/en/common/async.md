[Main](../main.md)

# Asynchronous interactions

The UI does not directly interact with receiving data.
All asynchronous actions are performed in WidgetModel.
To perform asynchronous operations in projects, the most commonly used library is [rxDart][rx_dart_link]
How to use it is described in detail in [this article][rx_dart_habr].


## subscribeHandleError

In WidgetModel, subscribing to change data in Observable occurs using the subscribeHandleError method
from class [WidgetModel](../../mwwm/lib/src/widget_model.dart). This approach allows you to standardize
processing received data and achieve modular error handling;

Example: 

```dart
 subscribeHandleError(
      _authInteractor.signIn(smsCodeState.value, _phoneNumber),
      (_) => _navigateToMain(),
      onError: (_) smsInputState.error(),
    );
```
    
## subscribe 
Subscription without centralized error handling.

Example:

```dart
      //selectNotificationSubject this is entity of BehaviorSubject - one of the types of streams from rxDart
      //onSelect Future data type method. Run when a change occurs in selectNotificationSubject
      subscribe(
         _notificationController.selectNotificationSubject,
         _notificationHandler.onSelect,
       );
```

## Future
Standard Dart Asynchronous Processing Engine. see details
possible in [official documentation][future_link].

Пример:

```dart
FlatButton(
  child: Text('Run Future'),
  onPressed: () {
    runMyFuture();
  },
)

void runMyFuture() {
  myTypedFuture().then((value) {
    print(value);
  }, onError: (error) {
    print(error);
  });
}

Future<bool> myTypedFuture() async {
  await Future.delayed(Duration(seconds: 1));
  return Future.error('Error from return');
}
```

## ErrorHandler
To handle errors received from a stream in the studio
extensions to the [ErrorHandler](../../mwwm/lib/src/error_handler.dart) class are used.
The ErrorHandler is passed to WidgetModel through the WidgetModelDependencies class - this is a wrapper over the required WidgetModel elements.
If you do not configure ErrorHandler in a screen component, using the subscribeHandleError method
errors will not be caught.

## bind 
To track single actions (clicking on a button, changing text, scrolling list) in the studio
used [Action](../../mwwm/lib/src/relation/event/action.dart). Represents a wrapper over a stream that registers
single actions and returns the first event from the stream. For convenience of subscribing to such events, the bind method was created.

Example:

```dart
void _bindActions() {
    bind(showCardAction, (_) => _navigateToShowCardScreen());
  }
```
 
[rx_dart_link]:https://pub.dev/packages/rxdart
[rx_dart_habr]:https://www.burkharts.net/apps/blog/rxdart-magical-transformations-of-streams/
[future_link]:https://api.flutter.dev/flutter/dart-async/Future-class.html