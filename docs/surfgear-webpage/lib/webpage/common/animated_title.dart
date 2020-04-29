import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:surfgear_webpage/webpage/common/offset_animated_widget.dart';

/// Виджет анимируемого заголовка
class AnimatedTitle extends StatefulWidget {
  /// Текст заголовка
  final String titleText;

  /// Стиль заголвка
  final TextStyle textStyle;

  /// Продолжительность анимации
  final Duration duration;

  /// Положение скролла
  final double scrollOffset;

  AnimatedTitle(
    this.titleText,
    this.textStyle,
    this.duration,
    this.scrollOffset,
  );

  @override
  State<StatefulWidget> createState() {
    return _AnimatedTitleState();
  }
}

class _AnimatedTitleState extends State<AnimatedTitle>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<Offset> _animation;

  bool _startOpacityAnimation = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _animation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollOffsetWidget(
      scrollOffset: widget.scrollOffset,
      hasScrolled: () {
        _animationController.forward();
        _startOpacityAnimation = true;
      },
      child: Column(
        children: <Widget>[
          AnimatedOpacity(
            opacity: _startOpacityAnimation ? 1.0 : 0.0,
            duration: widget.duration,
            child: SlideTransition(
              position: _animation,
              child: AutoSizeText(
                widget.titleText,
                textAlign: TextAlign.center,
                style: widget.textStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
