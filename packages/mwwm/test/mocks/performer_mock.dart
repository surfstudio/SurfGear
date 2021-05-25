import 'package:mocktail/mocktail.dart';
import 'package:mwwm/src/model/changes/changes.dart';
import 'package:mwwm/src/model/performer/performer.dart';

class PerformerMock<R, C extends Change<R>> extends Mock
    implements Performer<R, C> {}

class BroadcastMock<R, C extends FutureChange<R>> extends Mock
    implements Broadcast<R, C> {}
