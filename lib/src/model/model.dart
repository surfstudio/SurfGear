import 'package:mwwm/src/model/changes/changes.dart';
import 'package:mwwm/src/model/exceptions.dart';
import 'package:mwwm/src/model/performer/performer.dart';

/// Model is a mediator between WidgetModel and business logic.
///
/// Model abstracts the client (WidgetModel) from the supplier (repository,
/// service, storage, etc) and defines the contract between presentation and
/// service layers, thus allowing to develop both independently.
///
/// Model consists of [Change] and [Performer].
class Model {
  final List<Performer> _performers;

  Model(this._performers);

  /// Perform some change inside business logic once
  Future<R> perform<R>(Change<R> change) {
    for (var p in _performers) {
      try {
        return p.perform(change);
      } on TypeError catch (e) {
        continue;
      } catch (e) {
        return Future.error(e);
      }
    }

    return _throwError<R>(change);
  }

  /// Listen to changes of exact type
  Stream<R> listen<R, C extends Change<R>>() {
    for (var p in _performers) {
      try {
        if (p is Broadcast<R, C>) {
          //todo need resolver ?
          return p.broadcast;
        } else {
          continue;
        }
      } on TypeError {
        continue;
      } catch (e) {
        return Stream.error(e);
      }
    }

    return Stream.error(NoBroadcastPerformerException(C));
  }

  Future<D> _throwError<D>(Change change) => Future.error(
        NoPerformerException(change),
        StackTrace.fromString("${this.runtimeType} at 17"),
      );
}
