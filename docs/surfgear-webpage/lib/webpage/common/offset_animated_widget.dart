import 'package:flutter/cupertino.dart';

/// Виджет, который реагирует на положение скролла
class ScrollOffsetWidget extends StatefulWidget {
  /// Положение скролла
  final double scrollOffset;

  /// Вложенный виджет
  final Widget child;

  /// Колбэк который срабатывает когда положение скролла >= положению виджета
  final VoidCallback hasScrolled;

  ScrollOffsetWidget({
    @required this.scrollOffset,
    @required this.child,
    @required this.hasScrolled,
  });

  @override
  State<StatefulWidget> createState() {
    return ScrollOffsetWidgetState();
  }
}

class ScrollOffsetWidgetState extends State<ScrollOffsetWidget> {
  /// Ключ для поиска положения на экране
  GlobalKey _globalKey = GlobalKey();

  /// Триггер по которому определяется видимость анимации
  bool _isVisible = false;

  /// Поиск положения виджета по ключу
  double _getVerticalOffset() {
    final RenderBox renderBox = _globalKey.currentContext.findRenderObject();
    final Offset offset = renderBox.localToGlobal(Offset.zero);

    return offset.dy;
  }

  @override
  Widget build(BuildContext context) {
    // если позиция скролла >= вертикального положения виджета
    // запустить анимацию
    Future.delayed(Duration(milliseconds: 1), () {
      if (widget.scrollOffset >= _getVerticalOffset()) {
        if (!_isVisible) {
          widget.hasScrolled();
        }
        _isVisible = true;
      }
    });
    return Container(
      key: _globalKey,
      child: widget.child,
    );
  }
}
