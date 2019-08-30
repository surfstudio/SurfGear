# Асинхронные взаимодействия

[Главная](../main.md)

Напряму ui не взаимодействует с получением данных.
Все асинхронные действия проходят через WidgetModel. Там они обрабатываются и попадают на презентационный слой.
Для выполнения асинхронных операций в проектах используется преимущественно библиотека [rxDart](https://pub.dev/packages/rxdart)
Как ее использовать подробно описано в [этой статье на хабре](https://habr.com/ru/post/451292/).

Публичное API интеракторов строится на использовании Observable.[пример](res/observable_example.png)

Так-же можно использовать стандартные дартовские Future, но из-за более обширного функционала 
rxDart по преобразованию данных используем преимущественно реактивную библиотеку.

# Использование

1) subscribeHandleError
В WidgetModel подписка на изменение данных в Observable происходит через метод subscribeHandleError
из класса [WidgetModel](../../mwwm/lib/src/widget_model.dart). Такой подход позволяет стандартизировать
обработку получаемых данных и добиться модульности обработки ошибок(за счет расширения класса ErrorHandler);

Пример: 
 subscribeHandleError(
      _authInteractor.signIn(smsCodeState.value, _phoneNumber),
      (_) {
        _navigateToMain();
      },
      onError: (_) {
        smsInputState.error();
      },
    );
    
2) subscribe - подписка без обработки ошибок.
      //selectNotificationSubject это обьект класса BehaviorSubject - один из видов потоков из [rxDart](todo link)
      //onSelect метод типа данных Future. Выполняется когда в selectNotificationSubject просиходит како-либо изменение
      subscribe(
         _notificationController.selectNotificationSubject,
         _notificationHandler.onSelect,
       );

3) doFuture - //todo не нашел информации

4) Для обработки ошибок, получаемых из потока в студийной практике, 
используются расширения класса [HandleError](../../mwwm/lib/src/error_handler.dart).
HandleError является членом класса [WidgetModelDependencies](../../mwwm/lib/src/di/wm_dependencies.dart),
который используется для подключения зависимостей в WidgetModel. 
Если не сконфигурировать HandleError в компоненте экрана, при использовании метода subscribeHandleError 
ошибки отлавливаться не будут.

5) bind - Для отслеживания одиночных действий(нажатие на кнопку, изменение текста, скролл списка) в студии
используются [Action](../../mwwm/lib/src/event/action.dart). По-сути это обертка над потоком, которая регистрирует
одиночные действия и возвращает первое событие из потока. Для удобства подписки таких событий был создан метод bind.

Пример:

void _bindActions() {
    bind(showCardAction, (_) => _navigateToShowCardScreen());
  }

# Где используется?

С использованием rxDart работает внутренний студийный [http клиент](../../network/README.md)