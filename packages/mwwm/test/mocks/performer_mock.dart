import 'package:mocktail/mocktail.dart';
import 'package:mwwm/src/model/performer/performer.dart';
import 'package:mwwm/src/model/changes/changes.dart';

class PerformerMock<R, C extends Change<R>> extends Mock
    implements Performer<R, C> {}
