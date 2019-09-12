import 'package:flutter_template/domain/debug_options.dart';

class Config {
  final String url;
  final DebugOptions debugOptions;

  Config({
    this.url,
    this.debugOptions,
  });

  Config copyWith({
    String url,
    DebugOptions debugOptions,
  }) =>
      Config(
        url: url ?? this.url,
        debugOptions: debugOptions ?? this.debugOptions,
      );
}
