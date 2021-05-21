# Changelog

## 3.0.0

* Add `acceptUnique` to `StreamedState`.

## 2.0.0

* **Breaking Change:** `EntityStateBuilder`'s `child` argument replaced with `builder`
* **Breaking Change:** `EntityStateBuilder`'s `errorBuilder` argument now passes `Widget Function(BuildContext, Exception)`.
If you'd like to get `data` from `error` please use `errorDataBuilder` instead.
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
