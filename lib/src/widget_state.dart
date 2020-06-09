import 'package:flutter/widgets.dart';
import 'package:mwwm/mwwm.dart';

typedef WidgetModelBuilder = WidgetModel Function(BuildContext);

/// Class for widgets that has [WidgetModel]
/// You must provide [WidgetModel] in constructor or by [WidgetModelFactory]
abstract class CoreMwwmWidget extends StatefulWidget {
  /// Builder for `WidgetModel`
  /// There are two possibilities to provide `WidgetModel` :
  ///  1. Here by [widgetModelBuilder] (prefer)
  ///  2. Or by `WidgetModelFactory`
  ///
  /// By convention provide builder for WM this way
  /// ```
  /// const MyAwesomeWidget(
  ///   WidgetModel wmBuilder,
  /// ) : super(
  ///   widgetModelBuilder: wmBuilder ?? myBuilderFn
  /// );
  /// ```
  final WidgetModelBuilder widgetModelBuilder;

  const CoreMwwmWidget({
    Key key,
    @required this.widgetModelBuilder,
  })  : assert(widgetModelBuilder != null),
        super(key: key);
}

/// Base class for state of [CoreMwwmWidget].
/// Has [WidgetModel] from [initState].
abstract class WidgetState<WM extends WidgetModel>
    extends State<CoreMwwmWidget> {
  /// [WidgetModel] for widget.
  @protected
  WM wm;

  /// Descendants must call super firstly
  @mustCallSuper
  @override
  void initState() {
    wm = widget.widgetModelBuilder(context);

    super.initState();

    wm.onLoad();
    wm.onBind();
  }

  /// Descendants must call super in the end
  @override
  @protected
  @mustCallSuper
  void dispose() {
    wm.dispose();
    super.dispose();
  }
}
