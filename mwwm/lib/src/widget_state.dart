import 'package:flutter/widgets.dart';
import 'package:mwwm/mwwm.dart';
import 'package:mwwm/src/widget_model_creator.dart';

typedef WidgetStateBuilder = State Function();

/// Class for widgets that has [WidgetModel]
abstract class MwwmWidget extends StatefulWidget {
  final WidgetStateBuilder widgetStateBuilder;
  final WidgetModelBuilder widgetModelBuilder;

  const MwwmWidget({Key key, this.widgetStateBuilder, this.widgetModelBuilder})
      : super(key: key);

  @override
  State createState() {
    return widgetStateBuilder();
  }
}

/// Base class for state of [MwwmWidget].
/// Has [WidgetModel] from [initState].
abstract class WidgetState<WM extends WidgetModel> extends State<MwwmWidget> {
  final WidgetModelCreator _wmc = WidgetModelCreator<WM>();

  /// [WidgetModel] for widget.
  @protected
  WM wm;

  /// Descedants must call super firstly
  @mustCallSuper
  @override
  void initState() {
    var wmbBuilder = widget.widgetModelBuilder;
    if (wmbBuilder == null) {
      _wmc.initWm(context);
      wm = _wmc.wm;
    } else {
      wm = wmbBuilder(context);
    }
    super.initState();
  }

  /// Descedants must call super in the end
  @protected
  @mustCallSuper
  void dispose() {
    wm.dispose();
    super.dispose();
  }
}
