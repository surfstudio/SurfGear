[Главная](../docs/main.md)

[TOC]

# Push
Библиотека для реализации push уведомлений
В модуль вынесена основная работа с push уведомлениями.

## Использование

* Создать тип данных нотификации через наследование `NotificationPayload`
* Создать стратегию обработки нотификации через наследование `PushHandleStrategy`
* Создать фабрику стратегий через наследование `PushHandleStrategyFactory`

* Для получения нотификаций нужно создать экземпляр `MessagingService`
* Для показа нотификаций нужно создать экземпляр `NotificationController`.
* И передать созданные экземпляры при создании `PushHandler`, который будет создавать стратегию с помощью фабрики.

* В нотификации должно быть поле: `click_action: FLUTTER_NOTIFICATION_CLICK`
* в манифесте в <activity> нужно добавить интент фильтр:
```xml
<intent-filter>
      <action android:name="FLUTTER_NOTIFICATION_CLICK" />
      <category android:name="android.intent.category.DEFAULT" />
</intent-filter>
```
