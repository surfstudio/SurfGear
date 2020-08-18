#### [SurfGear](https://github.com/surfstudio/SurfGear)

# event_filter

Mechanism for filtering events.

## Usage

Main classes:

1. [Error implementation: Error event](lib/src/impl/error/error_event.dart)
2. [Error implementation: Default error event filter](lib/src/impl/error/default_error_filter.dart)
3. [Error implementation: Default error event filter strategy](lib/src/impl/error/default_error_filter_strategy.dart)
4. [Error implementation: Default error event strategy](lib/src/impl/error/default_error_strategy.dart)
5. [Error implementation: Default error event strategy provider](lib/src/impl/error/default_error_strategy_provider.dart)
6. [Event](lib/src/event/event.dart)
7. [Factory of event filter strategy](lib/src/factory/event_filter_strategy_factory.dart)
8. [Factory of event strategy](lib/src/factory/event_strategy_factory.dart)
9. [Event strategy](lib/src/strategy/event_strategy.dart)
10. [Event filter strategy](lib/src/strategy/event_filter_strategy.dart)
11. [Event strategy provider](lib/src/event_stragegy_provider.dart)
12. [Event filter](lib/src/event_filter.dart)

## Event

Base class for any event.

## Event Strategy

A strategy of processing event. That is mean we implement there how we react to event.

## Event Filter Strategy

A strategy of filtering event. If event has been pass through the filter,
the strategy will return that event, else return null.
Inside it we must solve will we react to event or not.

## Strategy factory
Both are `EventStrategyFactory` and `EventFilterStrategyFactory` return strategy by event.
It will be select by event type from map. If map not contain this event type,
default strategy will be return.

## Event Filter
It can be used for filtering events. Events must be passed to filter function. Filter get from
factory necessary strategy of filtering and use it for this event.

## Event strategy provider
This behaviour solve what will happen when event will. It get strategy by the factory and use it
for this event.

# Error implementation
This implementation of reaction and filtering error event. More details of using it you can
look in example.