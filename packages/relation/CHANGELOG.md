# Changelog

## 3.1.0 - 2021-06-28

* Stable release

## 3.1.0-dev.1 - 2021-06-21

* Marked as deprecated `fromStream` constructors of `StreamedState` and `EntityState`
* Added possibility to configure nullable type by generic in `StreamedStateBuilder`

## 3.0.0 - 2021-06-07

* Stable release

## 4.0.0-dev.1 - 2021-06-04

* **Breaking Change:** `Action` renamed to `StreamedAction`
* **Breaking Change:** `StreamedAction`'s, `ScrollOffsetAction`'s and `TextEditingAction`'s `onChanged` callback is named parameter now.
* **Breaking Change:** replaced `Object` with `Exception` in `EntityEvent` and all derived classes
* **Breaking Change:** removed value return from `Event.accept`, `EntityEvent.accept` and all derived
* **Breaking Change:** removed nullable types where possible
* Add `acceptUnique` param to `StreamedAction`.
* Add `acceptUnique` method to `StreamedState`.

## 2.0.1 - 2021-05-30

* Stable release

## 2.0.1-dev.1 - 2021-05-25

* Apply new lint rules.

## 2.0.0

* **Breaking Change:** `EntityStateBuilder`'s `child` argument replaced with `builder`
* **Breaking Change:** `EntityStateBuilder`'s `errorBuilder` argument now passes `Widget Function(BuildContext, Exception)`. If you'd like to get `data` from `error` please use `errorDataBuilder` instead.
* Add the ability to get an `error` in `EntityStateBuilder` from `errorChild`.
* Add `data` argument to `EntityStreamedState`.
* Update `rxdart` dependency to `0.27.0`.

## 1.0.0

* Migrated to null safety, min SDK is `2.12.0`
* Remove `ControllerAction`

## 0.0.4-dev.3

* Fixed loading and error builders on empty stream data
* Update README.md

## 0.0.4-dev.1

* Up rxdart dependency

## 0.0.3-dev.4
  
* Add 'from' constructors to StreamedStates

## 0.0.3-dev.3

* Change error type from Exception to Object

## 0.0.2-dev.5

* Added previous value to loadState
* Added error to data builder

## 0.0.2-dev.4

* Fix lint hints

## 0.0.2 - 21.0.2020

* Initial release
