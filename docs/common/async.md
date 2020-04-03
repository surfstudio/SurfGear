[Главная](../main.md)

# Асинхронные взаимодействия

Напрямую UI не взаимодействует с получением данных.
Все асинхронные действия выполняются в WidgetModel.
Для выполнения асинхронных операций в проектах используется преимущественно библиотека [rxDart][rx_dart_link]
Как ее использовать подробно описано в [этой статье][rx_dart_habr].


## subscribeHandleError

В WidgetModel подписка на изменение данных в Observable происходит c использованием метода subscribeHandleError
из класса [WidgetModel](../../mwwm/lib/src/widget_model.dart). Такой подход позволяет стандартизировать
обработку получаемых данных и добиться модульности обработки ошибок;

Пример: 

```dart
 subscribeHandleError(
      _authInteractor.signIn(smsCodeState.value, _phoneNumber),
      (_) => _navigateToMain(),
      onError: (_) smsInputState.error(),
    );
```
    
## subscribe 
подписка без централизованной обработки ощибок.

Пример:

```dart
      //selectNotificationSubject это обьект класса BehaviorSubject - один из видов потоков из rxDart
      //onSelect метод типа данных Future. Выполняется когда в selectNotificationSubject просиходит како-либо изменение
      subscribe(
         _notificationController.selectNotificationSubject,
         _notificationHandler.onSelect,
       );
```

## Future
Стандартный механизм обработки асинхронных операций в Dart. Подробно ознакомиться
можно в [официальной документации][future_link].

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
Для обработки ошибок, получаемых из потока, в студийной практике
используются расширения класса [ErrorHandler](../../mwwm/lib/src/error_handler.dart).
ErrorHandler поставляется на WidgetModel через класс WidgetModelDependencies - это обертка над обязательными состоавляющим WidgetModel.
Если не сконфигурировать ErrorHandler в компоненте экрана, при использовании метода subscribeHandleError 
ошибки отлавливаться не будут.

## bind 
Для отслеживания одиночных действий(нажатие на кнопку, изменение текста, скролл списка) в студии
используются [Action](../../mwwm/lib/src/relation/event/action.dart). Представляет обертку над потоком, которая регистрирует
одиночные действия и возвращает первое событие из потока. Для удобства подписки таких событий был создан метод bind.

Пример:

```dart
void _bindActions() {
    bind(showCardAction, (_) => _navigateToShowCardScreen());
  }
```
 
[rx_dart_link]:https://pub.dev/packages/rxdart
[rx_dart_habr]:https://habr.com/ru/post/451292/
[future_link]:https://api.flutter.dev/flutter/dart-async/Future-class.html