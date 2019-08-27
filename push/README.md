[Главная](../docs/main.md)

[TOC]

# Push
Библиотека для реализации push уведомлений
В модуль вынесена основная работа с push уведомлениями.

## Использование
* Для получения нотификаций нужно создать экземпляр PushManager и назначить обработчики событий: onMessage, onLaunch, onResume.
* Для показа нотификаций нужно создать экземпляр NotificationController.
* Для обработки нажатий на нотификаци использовать назначить обработчик onSelectNotification
* В нотификации должно быть поле: `click_action: FLUTTER_NOTIFICATION_CLICK`
* в манифесте в <activity> нужно добавить интент фильтр:
```xml
<intent-filter>
      <action android:name="FLUTTER_NOTIFICATION_CLICK" />
      <category android:name="android.intent.category.DEFAULT" />
</intent-filter>
```
