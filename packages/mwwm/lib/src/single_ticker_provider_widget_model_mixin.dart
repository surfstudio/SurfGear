import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

import '../mwwm.dart';

/// Ticker provider for [WidgetModel]
/// based on [SingleTickerProviderStateMixin]
/// https://api.flutter.dev/flutter/widgets/SingleTickerProviderStateMixin-mixin.html
mixin SingleTickerProviderWidgetModelMixin on WidgetModel
    implements TickerProvider {
  Ticker _ticker;

  @override
  Ticker createTicker(TickerCallback onTick) {
    assert(() {
      if (_ticker == null) return true;
      throw FlutterError.fromParts(
        <DiagnosticsNode>[
          ErrorSummary(
            '$runtimeType is a SingleTickerProviderWidgetModelMixin but multiple tickers were created.',
          ),
          ErrorDescription(
            'A SingleTickerProviderWidgetModelMixin can only be used as a TickerProvider once.',
          ),
          ErrorHint(
            'If a WidgetModel is used for multiple AnimationController objects, or if it is passed to other '
            'objects and those objects might use it more than one time in total, then instead of '
            'mixing in a SingleTickerProviderWidgetModelMixin, implement your own TickerProviderWidgetModelMixin.',
          ),
        ],
      );
    }());
    _ticker =
        Ticker(onTick, debugLabel: kDebugMode ? 'created by $this' : null);
    return _ticker;
  }

  @override
  void dispose() {
    assert(() {
      if (_ticker == null || !_ticker.isActive) return true;
      throw FlutterError.fromParts(
        <DiagnosticsNode>[
          ErrorSummary(
            '$this was disposed with an active Ticker.',
          ),
          ErrorDescription(
            '$runtimeType created a Ticker via its SingleTickerProviderWidgetModelMixin, but at the time '
            'dispose() was called on the mixin, that Ticker was still active. The Ticker must '
            'be disposed before calling super.dispose().',
          ),
          ErrorHint(
            'Tickers used by AnimationControllers '
            'should be disposed by calling dispose() on the AnimationController itself. '
            'Otherwise, the ticker will leak.',
          ),
          _ticker.describeForError('The offending ticker was'),
        ],
      );
    }());
    super.dispose();
  }
}
