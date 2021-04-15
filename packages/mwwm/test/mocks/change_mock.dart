import 'package:mocktail/mocktail.dart';
import 'package:mwwm/src/model/changes/changes.dart';

class ChangeMock<T> extends Mock implements Change<T> {}

class FutureChangeMock<R> extends Mock implements FutureChange<R> {}
