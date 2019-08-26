import 'package:mwwm/src/entity_state.dart';
import 'package:mwwm/src/event/event.dart';
import 'package:rxdart/rxdart.dart';

///Состояние некого типа, обёрнутое в поток
///Характерно для связи WidgetModel -> Widget
class StreamedState<T> implements Event<T> {
  final BehaviorSubject<T> _stateSubject;

  T get value => _stateSubject.value;

  @override
  Observable<T> get stream => _stateSubject.stream;

  StreamedState([T initialData])
      : _stateSubject = initialData != null
            ? BehaviorSubject.seeded(initialData)
            : BehaviorSubject();

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
    final newState = EntityState<T>.content(data);
    return super.accept(newState);
  }

  @override
  Future<void> error([dynamic error]) {
    final newState = EntityState<T>.error(error);
    return super.accept(newState);
  }

  @override
  Future<void> loading() {
    final newState = EntityState<T>.loading();
    return super.accept(newState);
  }
}

///Связь WidgetModel -> Widget,
///имеющая состояние пагинации/загрузки/ошибки/контента
class EntityPaginationState<T> extends EntityStreamedState<List<T>> {
  List<T> data = <T>[];
  int page = 0;

  bool get isLoading => value?.isLoading ?? false;

  Future<void> addAll([List<T> data]) {
    this.data.addAll(data);
    final newState = EntityState.content(this.data);
    return super.accept(newState);
  }

  Future<void> loadNext() {
    final newState = EntityState(data: data, isLoading: true);
    return super.accept(newState);
  }

  Future<void> errorNext([dynamic error]) {
    final newState =
        EntityState(data: data, isLoading: false, hasError: true, error: error);
    return super.accept(newState);
  }

  Future<void> clear() {
    this.data.clear();
    this.page = 0;
    final newState = EntityState.content(this.data);
    return super.accept(newState);
  }
}
