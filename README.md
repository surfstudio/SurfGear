# <img src="logo.gif" title="logo" width="400" height="400" align="middle" />


A set of libraries, standards, tools used by Surf studio when developing on Flutter.

This repository is intended **for demonstration**.

**Individual libraries will have their own repositories (link to them will be provided).**

[**Documentation and standards**](docs/en/main.md)

## Modules

Statuses:

- surf - module for internal use only
- alpha, beta, release - statuses for modules that can be used outside

| Name | Description | Status |
| ---------- | ---------- | -------- |
| [analytics](packages/analytics/)|Unified interface for working with analytics services | surf |
| [auto_reload](packages/auto_reload/)| A library that allows you to perform any actions at a given frequency | surf |
| [background_worker](packages/background_worker/)| Isolate Helper | surf |
| [bottom_navigation_bar](packages/bottom_navigation_bar/)| Widget with navigation buttons between screens | surf |
| [bottom_sheet](packages/bottom_sheet/) | Scrollable Curtain Widget | surf |
| [build_context_holder](packages/build_context_holder/) | The context keeper of the last created widget | surf |
| [datalist](packages/datalist/) | List that makes pagination easier to work with | surf |
| [db_holder](packages/db_holder/) | Database interface | surf |
| [event_filter](packages/event_filter/) | Event filtering interface | surf |
| [geolocation](packages/geolocation/) | Library for working with geo-location | surf |
| [injector](packages/injector/) | Dependency Injection Tool | surf |
| [ink_widget](packages/ink_widget/) | Wrapper over InkWell | surf |
| [keyboard_listener](packages/keyboard_listener/) | Keyboard widget | surf |
| [logger](packages/logger/) | Library for logging | surf |
| [mixed_list](packages/mixed_list/) | Widget for displaying items of different types as a list | surf |
| [mwwm](https://pub.dev/packages/mwwm) | MWWM Architecture Components Library | beta |
| [network](packages/network/) | Library for working with server requests | surf |
| [network_cache](packages/network_cache/) | Utility for caching responses from the server | surf |
| [permission](packages/permission/) | Library for requesting access to various device functions (geolocation, contact list, etc.) | surf |
| [push_notification](packages/push_notification/) | Library for working with notifications | surf |
| [relation](https://pub.dev/packages/relation) | Communication Widget - Wm Used In Surf | alpha |
| [render_metrics](https://pub.dev/packages/render_metrics) | Library for removing metrics from a widget | release |
| [storage](packages/storage/) | Interface for working with storages | surf |
| [surf_mwwm](packages/surf_mwwm/) | A package that combines mwwm, injector, relation and various extension methods | surf |
| [surf_util](packages/surf_util/) | Set of utilities | surf |
| [swipe_refresh](packages/swipe_refresh/) | Pull-to-refresh widget | surf |
| [tabnavigator](packages/tabnavigator/) | Library for navigation between tabs of the main screen | surf |
| [virtual_keyboard](packages/virtual_keyboard/) | Widget for displaying virtual keyboard | surf |


## How to ask questions?

You can ask questions of interest either in the issue to the repository,
or in a special [chat on Telegram](https://t.me/SurfGear).

## Thanks

Many thanks to the entire **Surf team** for their contribution to the development of the repository!

## License
```
Copyright (c) 2019-present, SurfStudio LLC

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
