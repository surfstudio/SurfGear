import 'dart:async';
import 'dart:math' show max;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:surfgear_webpage/assets/images.dart';
import 'package:surfgear_webpage/common/widgets.dart';
import 'package:surfgear_webpage/main.dart';

class MainPageFooter extends StatelessWidget {
  final Stream scrollChangesStream;

  MainPageFooter({
    Key key,
    @required this.scrollChangesStream,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        OverflowBox(
          minWidth: max(MediaQuery.of(context).size.width, 1920),
          maxWidth: double.infinity,
          child: Image.asset(
            imgBackground,
            fit: BoxFit.fitWidth,
            alignment: Alignment(0.0, 0.85),
          ),
        ),
        Align(
          alignment: Alignment(0.0, -0.2),
          child: _TextAndButton(
            scrollChangesStream: scrollChangesStream,
          ),
        ),
      ],
    );
  }
}

class _TextAndButton extends StatefulWidget {
  final Stream scrollChangesStream;

  _TextAndButton({
    Key key,
    @required this.scrollChangesStream,
  }) : super(key: key);

  @override
  __TextAndButtonState createState() => __TextAndButtonState();
}

class __TextAndButtonState extends State<_TextAndButton>
    with SingleTickerProviderStateMixin {
  static final _opacityTween = Tween(begin: 0.0, end: 1.0);

  StreamSubscription _subscription;

  AnimationController _animationController;
  Animation<double> _textAnimation;
  Animation<double> _buttonAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..addListener(() => setState(() {}));

    _textAnimation = _opacityTween.animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.0, 0.3),
    ));

    _buttonAnimation = _opacityTween.animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.7, 1.0),
    ));

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _subscription = widget.scrollChangesStream.listen(
        (_) => _animateWidget(),
      );
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    _animationController.dispose();
    super.dispose();
  }

  void _animateWidget() {
    if (_animationController.isCompleted) return;

    RenderBox renderBox = context.findRenderObject();
    final offset = renderBox.localToGlobal(Offset.zero);

    if (offset.dy < MediaQuery.of(context).size.height * 0.8) {
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: FadeTransition(
            opacity: _textAnimation,
            child: AutoSizeText(
              'Каталог модулей, для вас',
              maxLines: 1,
              style: GoogleFonts.rubik(
                color: Colors.white,
                fontSize: 38,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ),
        SizedBox(height: 32.0),
        FadeTransition(
          opacity: _buttonAnimation,
          child: _CatalogButton(),
        ),
      ],
    );
  }
}

class _CatalogButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WebButton(
      onPressed: () => Navigator.of(context).pushNamed(Router.catalog),
      buttonBuilder: (context, isHovering) {
        return DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            color: isHovering ? Colors.white : Colors.transparent,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 18.0,
              horizontal: 40.0,
            ),
            child: Text(
              'СМОТРЕТЬ',
              style: GoogleFonts.comfortaa(
                color: isHovering ? Colors.grey[850] : Colors.white,
                fontSize: 18.0,
                letterSpacing: 1.1,
              ),
            ),
          ),
        );
      },
    );
  }
}
