import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

import '../mwwm.dart';

/// Single ticker provider for [WidgetModel]
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

/// Ticker provider for [WidgetModel]
/// based on [TickerProviderStateMixin]
/// https://api.flutter.dev/flutter/widgets/TickerProviderStateMixin-mixin.html
mixin TickerProviderWidgetModelMixin on WidgetModel implements TickerProvider {
  Set<Ticker> _tickers;

  @override
  Ticker createTicker(TickerCallback onTick) {
    _tickers ??= <_WidgetTicker>{};
    final result = _WidgetTicker(onTick, this, debugLabel: 'created by $this');
    _tickers.add(result);
    return result;
  }

  void _removeTicker(_WidgetTicker ticker) {
    assert(_tickers != null);
    assert(_tickers.contains(ticker));
    _tickers.remove(ticker);
  }

  @override
  void dispose() {
    assert(() {
      if (_tickers != null) {
        for (final ticker in _tickers) {
          if (ticker.isActive) {
            throw FlutterError.fromParts(
              <DiagnosticsNode>[
                ErrorSummary(
                  '$this was disposed with an active Ticker.',
                ),
                ErrorDescription(
                  '$runtimeType created a Ticker via its TickerProviderWidgetModelMixin, but at the time '
                  'dispose() was called on the mixin, that Ticker was still active. The Ticker must '
                  'be disposed before calling super.dispose().',
                ),
                ErrorHint(
                  'Tickers used by AnimationControllers '
                  'should be disposed by calling dispose() on the AnimationController itself. '
                  'Otherwise, the ticker will leak.',
                ),
                ticker.describeForError('The offending ticker was'),
              ],
            );
          }
        }
      }
      return true;
    }());
    super.dispose();
  }
}

// This class should really be called _DisposingTicker or some such, but this
// class name leaks into stack traces and error messages and that name would be
// confusing. Instead we use the less precise but more anodyne "_WidgetTicker",
// which attracts less attention.
class _WidgetTicker extends Ticker {
  _WidgetTicker(
    TickerCallback onTick,
    this._creator, {
    String debugLabel,
  }) : super(
          onTick,
          debugLabel: debugLabel,
        );

  final TickerProviderWidgetModelMixin _creator;

  @override
  void dispose() {
    _creator._removeTicker(this);
    super.dispose();
  }
}
