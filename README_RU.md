<!--![logo](logo.gif)-->

# <img src="logo.gif" title="logo" width="400" height="400" align="middle"/>


Набор библиотек, стандартов, инструментов используемых студией Surf при разработке на Flutter.

Данный репозиторий предназанчен скорее **для демонстрации**.

**Отдельные библиотеки будут иметь свои репозитории(ссылка на них будет указана).**

[**Документация и стандарты**](docs/ru/main.md)

## Модули

Статусы:

- surf - модуль только для внутреннего использования
- alpha, beta, release - статусы для модулей, которые могут использоваться во вне

| Название | Описание | Статус |
|----------|----------|--------|
| [analytics](https://pub.dev/packages/analytics) | Единый интерфейс для работы с сервисами аналитики | surf |
| [auto_reload](https://pub.dev/packages/auto_reload) | Библиотека, позволяющая выполнять какие-либо действия с заданной периодичностью | surf |
| [background_worker](https://pub.dev/packages/background_worker) | Хелпер для работы с изолятами | surf |
| [bottom_navigation_bar](https://pub.dev/packages/bottom_navigation_bar) | Виджет с кнопками навигации между экранами | surf |
| [bottom_sheet](https://pub.dev/packages/bottom_sheet) | Виджет раскрывающейся шторки с возможностью прокрутки | surf |
| [build_context_holder](https://pub.dev/packages/build_context_holder) | Хранитель контекста последнего созданного виджета | surf |
| [datalist](https://pub.dev/packages/datalist) | Список, упрощающий работу с пагинацией | surf |
| [geolocation](packages/geolocation/) | Библиотека для работы с геопозицией | surf |
| [ink_widget](https://pub.dev/packages/ink_widget) | Обертка над InkWell | surf |
| [keyboard_listener](packages/keyboard_listener/) | Виджет для отслеживания состояния клавиатуры | surf |
| [mwwm](https://pub.dev/packages/mwwm) | Библиотека с компонентами архитектуры MWWM | beta |
| [permission](packages/permission/) | Библиотека для запроса доступа к различным функциям устройства (геолокация, список контактов и т.д.) | surf |
| [push_notification](https://pub.dev/packages/push_notification) | Библиотека для работы с уведомлениями | surf |
| [relation](https://pub.dev/packages/relation) | Свзяь Widget - Wm , используемая в Surf | alpha |
| [render_metrics](https://pub.dev/packages/render_metrics) | Библотека для снятия метрик с виджета | release |
| [surf_injector](https://pub.dev/packages/surf_injector) | Dependency Injection Tool | surf |
| [surf_logger](https://pub.dev/packages/surf_logger) | Библиотека для логирования | surf |
| [surf_mwwm](https://pub.dev/packages/surf_mwwm) | Пакет, объединяющий в себе mwwm, injector, relation и различные методы расширения | surf |
| [surf_network](https://pub.dev/packages/surf_network) | Библиотека для работы с запросами к серверу | surf |
| [surf_util](https://pub.dev/packages/surf_util) | Набор утилит | surf |
| [swipe_refresh](https://pub.dev/packages/swipe_refresh) | Виджет для работы с pull-to-refresh | surf |
| [tabnavigator](https://pub.dev/packages/tabnavigator) | Библиотека для навигации между табами главного экрана | surf |
| [virtual_keyboard](packages/virtual_keyboard/) | Виджет для отображения виртуальной клавиатуры | surf |


## Как задать вопросы?

Задать интересующие вопросы можно либо в issue к репозиторию,
либо в специальном [чате в Telegram](https://t.me/SurfGear).

## Благодарности

За вклад в развитие репозитория огромное спасибо всей команде Surf!

## Лицензия
```
Copyright (c) 2019-present,  SurfStudio LLC

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
