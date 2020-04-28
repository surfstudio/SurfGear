import 'dart:math' show max;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:surfgear_webpage/assets/images.dart';
import 'package:surfgear_webpage/webpage/webpage_widget.dart';
import 'package:surfgear_webpage/widgets.dart';

class HeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        DecoratedBox(
          position: DecorationPosition.foreground,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 0.35, 1.0],
              colors: [
                Color(0x050E16).withOpacity(0.81),
                Color(0x0F263C).withOpacity(0.36),
                Colors.transparent,
              ],
            ),
          ),
          child: OverflowBox(
            minWidth: max(MediaQuery.of(context).size.width, 1920),
            maxWidth: double.infinity,
            child: Image.asset(
              imgBackground,
              fit: BoxFit.fitWidth,
              alignment: Alignment(0.0, -0.3),
            ),
          ),
        ),
        _LogoAndText(),
        Align(
          alignment: Alignment.topCenter,
          child: _Menu(),
        ),
      ],
    );
  }
}

class _LogoAndText extends StatefulWidget {
  @override
  __LogoAndTextState createState() => __LogoAndTextState();
}

class __LogoAndTextState extends State<_LogoAndText> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    if (!_visible) {
      Future.delayed(const Duration(milliseconds: 1000),
          () => setState(() => _visible = true));
    }

    final children = <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 56.0,
          vertical: 32.0,
        ),
        child: AnimatedOpacity(
          opacity: _visible ? 1 : 0,
          duration: const Duration(milliseconds: 350),
          child: Image.asset(imgLogo),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 56.0,
          vertical: 32.0,
        ),
        child: AnimatedOpacity(
          opacity: _visible ? 1 : 0,
          duration: const Duration(milliseconds: 350),
          child: AutoSizeText(
            'Плагины для Flutter-проектов',
            textAlign: TextAlign.center,
            maxLines: 2,
            style: GoogleFonts.rubik(
              color: Colors.white,
              fontSize: 42.0,
            ),
          ),
        ),
      ),
    ];

    if (MediaQuery.of(context).size.width > MEDIUM_SCREEN_WIDTH) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      );
    }
  }
}

class _Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < SMALL_SCREEN_WIDTH) {
      return Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.only(top: 72.0, right: 72.0),
          child: _MenuBurgerButton(),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(top: 87.0),
      child: FractionallySizedBox(
        widthFactor: screenWidth > MEDIUM_SCREEN_WIDTH ? 0.5 : 0.7,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _MenuButton.modules(),
            _MenuButton.wiki(),
            _MenuButton.github(),
          ],
        ),
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  _MenuButton({
    Key key,
    @required this.title,
    @required this.onPressed,
  }) : super(key: key);

  _MenuButton.modules({Key key})
      : this(
          key: key,
          title: 'МОДУЛИ',
          onPressed: () {}, //TODO
        );

  _MenuButton.wiki({Key key})
      : this(
          key: key,
          title: 'ВИКИ',
          onPressed: () {}, //TODO
        );

  _MenuButton.github({Key key})
      : this(
          key: key,
          title: 'ГИТХАБ',
          onPressed: () {}, //TODO
        );

  @override
  Widget build(BuildContext context) {
    return WebButton(
      onPressed: onPressed,
      buttonBuilder: (context, isHovering) {
        return Text(
          title,
          style: GoogleFonts.comfortaa(
            color: Colors.white,
            fontSize: 24.0,
            decoration:
                isHovering ? TextDecoration.underline : TextDecoration.none,
          ),
        );
      },
    );
  }
}

class _MenuBurgerButton extends StatefulWidget {
  @override
  __MenuBurgerButtonState createState() => __MenuBurgerButtonState();
}

class __MenuBurgerButtonState extends State<_MenuBurgerButton>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildButton(_showMenu);
  }

  Widget _buildButton(VoidCallback onPressed) {
    return CursorOnHoverWidget(
      child: IconButton(
        onPressed: onPressed,
        iconSize: 58.0,
        icon: AnimatedIcon(
          color: Colors.white,
          icon: AnimatedIcons.menu_close,
          progress: _animationController,
        ),
      ),
    );
  }

  void _showMenu() {
    _animationController.forward();

    OverlayEntry entry;

    entry = OverlayEntry(
      builder: (context) {
        return Material(
          color: Colors.transparent,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            color: Colors.black.withOpacity(0.8),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 72.0, right: 72.0),
                    child: _buildButton(() {
                      _animationController.reverse();
                      entry.remove();
                    }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 82.0),
                  child: _MenuButton.modules(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 82.0),
                  child: _MenuButton.wiki(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 82.0),
                  child: _MenuButton.github(),
                ),
              ],
            ),
          ),
        );
      },
    );

    Overlay.of(context).insert(entry);
  }
}