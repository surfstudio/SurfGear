import 'package:mwwm/src/entity_state.dart';
import 'package:mwwm/src/event/event.dart';
import 'package:rxdart/rxdart.dart';

///Состояние некого типа, обёрнутое в поток
///Характерно для связи WidgetModel -> Widget
class StreamedState<T> implements Event<T> {
  BehaviorSubject<T> _stateSubject = BehaviorSubject();

  T get value => _stateSubject.value;

  @override
  Observable<T> get stream => _stateSubject.stream;

  StreamedState([T initialData]) {
    if (initialData != null) accept(initialData);
  }

  @override
  Future<void> accept([T data]) {
    _stateSubject.add(data);
    return _stateSubject.stream.first.wrapped;
  }

  dispose() {
    _stateSubject.close();
  }
}

///Связь WidgetModel -> Widget, имеющая состояние загрузки/ошибки/контента
class EntityStreamedState<T> extends StreamedState<EntityState<T>>
    implements EntityEvent<T> {
  EntityStreamedState([EntityState<T> initialData]) : super(initialData);

  @override
  Future<void> content([T data]) {
    final newState = EntityState.content(data);
    return super.accept(newState);
  }

  @override
  Future<void> error([Exception error]) {
    final newState = EntityState.error(error);
    return super.accept(newState);
  }

  @override
  Future<void> loading() {
    final newState = EntityState.loading();
    return super.accept(newState);
  }
}
