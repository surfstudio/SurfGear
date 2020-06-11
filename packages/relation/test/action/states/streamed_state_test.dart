import 'package:flutter_test/flutter_test.dart';
import 'package:relation/src/relation/state/streamed_state.dart';

void main() {
  test('StreamedState accept([T data]) test', () {
    final streamedState = StreamedState<String>();
    streamedState.stream.listen((event) {
      expect(event, 'test');
    });
    streamedState.accept('test');
  });

  test('StreamedState dispose() test', () {
    final streamedState = StreamedState<String>();
    streamedState.dispose();
    expect(streamedState.stateSubject.isClosed, true);
  });
}
