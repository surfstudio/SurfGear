import 'package:injector/injector.dart';

/// Базовый [Component] для всех [WidgetModel]
abstract class BaseWidgetModelComponent<WM> implements Component {
  WM get wm;
}
