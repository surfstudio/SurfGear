import 'package:mwwm/src/model/changes/changes.dart';
import 'package:mwwm/src/model/exceptions.dart';
import 'package:mwwm/src/model/performer/performer.dart';

/// Contract between Presentation layer and Bussines logic
class Model {
  final List<Performer> performers;

  Model(this.performers);

  /// Perform some change inside bussiness logic once
  Future<R> perform<R>(Change<R> change) {
    for (var p in performers) {
      try {
        return p.perform(change);
      } on TypeError {
        continue;
      } catch (e) {
        return Future.error(e);
      }
    }

    return _throwError<R>(change);
  }

  /// Listen to changes of exact type
  Stream<R> listen<C extends Change, R>() {
    for (var p in performers) {
      try {
        if (p is Broadcast<C, R>) { //todo need resolver ?
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
