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
| [analytics](packages/analytics/) | Единый интерфейс для работы с сервисами аналитики | surf |
| [auto_reload](packages/auto_reload/) | Библиотека, позволяющая выполнять какие-либо действия с заданной периодичностью | surf |
| [background_worker](packages/background_worker/) | Хелпер для работы с изолятами | surf |
| [bottom_navigation_bar](packages/bottom_navigation_bar/) | Виджет с кнопками навигации между экранами | surf |
| [bottom_sheet](packages/bottom_sheet/) | Виджет раскрывающейся шторки с возможностью прокрутки | surf |
| [build_context_holder](packages/build_context_holder/) | Хранитель контекста последнего созданного виджета | surf |
| [datalist](packages/datalist/) | Список, упрощающий работу с пагинацией | surf |
| [db_holder](packages/db_holder/) | Интерфейс для работы с базами данных | surf |
| [event_filter](packages/event_filter/) | Интерфейс для филтрации событий | surf |
| [geolocation](packages/geolocation/) | Библиотека для работы с геопозицией | surf |
| [injector](packages/injector/) | Инструмент для внедрения зависимостей | surf |
| [logger](packages/logger/) | Библиотека для логирования | surf |
| [mixed_list](packages/mixed_list/) | Виджет для отображения элементов разного типа в виде списка | surf |
| [mwwm](packages/mwwm/) | Библиотека с компонентами архитектуры MWWM | alpha |
| [network](packages/network/) | Библиотека для работы с запросами к серверу | surf |
| [network_cache](packages/network_cache/) | Утилита для кеширования ответов от сервера | surf |
| [permission](packages/permission/) | Библиотека для запроса доступа к различным функциям устройства (геолокация, список контактов и т.д.) | surf |
| [push](packages/push/) | Библиотека для работы с уведомлениями | surf |
| [relation](packages/relation/) | Свзяь Widget - Wm , используемая в Surf | surf |
| [storage](packages/storage/) | Интерфейс для работы с хранилищами | surf |
| [surf_mwwm](packages/surf_mwwm/) | Пакет, объединяющий в себе mwwm, injector, relation и различные методы расширения | surf |
| [surf_util](packages/surf_util/) | Набор утилит | surf |
| [swipe_refresh](packages/swipe_refresh/) | Виджет для работы с pull-to-refresh | surf |
| [tabnavigator](packages/tabnavigator/) | Библиотека для навигации между табами главного экрана | surf |


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