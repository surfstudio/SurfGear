import 'package:flutter/widgets.dart';
import 'package:mwwm/mwwm.dart';

/// Class for widgets that has [WidgetModel]
abstract class CoreMwwmWidget extends StatefulWidget {

  const CoreMwwmWidget({
    Key key,
  }) : super(key: key);


  WidgetModel createWidgetModel(BuildContext context);
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
    wm = widget.createWidgetModel(context);
    super.initState();

    wm.onLoad();
    wm.onBind();
  }

  /// Descendants must call super in the end
  @protected
  @mustCallSuper
  void dispose() {
    wm.dispose();
    super.dispose();
  }
}
