import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:surfgear_webpage/const.dart';
import 'package:surfgear_webpage/main.dart';
import 'package:surfgear_webpage/webpage/common/widgets.dart';
import 'package:surfgear_webpage/webpage/webpage_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class Menu extends StatelessWidget {
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
  final void Function(BuildContext context) onPressed;

  _MenuButton({
    Key key,
    @required this.title,
    @required this.onPressed,
  }) : super(key: key);

  _MenuButton.modules({Key key})
      : this(
          key: key,
          title: 'МОДУЛИ',
          onPressed: (context) {
            Navigator.of(context).pushNamed(Router.catalog);
          },
        );

  _MenuButton.wiki({Key key})
      : this(
          key: key,
          title: 'ВИКИ',
          onPressed: (_) => launch(wikiUrl),
        );

  _MenuButton.github({Key key})
      : this(
          key: key,
          title: 'ГИТХАБ',
          onPressed: (_) => launch(githubUrl),
        );

  @override
  Widget build(BuildContext context) {
    return WebButton(
      onPressed: () => onPressed(context),
      buttonBuilder: (context, isHovering) {
        return Text(
          title,
          style: GoogleFonts.comfortaa(
            color: Theme.of(context).brightness == Brightness.light
                ? Color(0xFF181818)
                : Colors.white,
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
    return Builder(builder: (context) {
      return Clickable(
        child: IconButton(
          onPressed: onPressed,
          iconSize: 58.0,
          icon: AnimatedIcon(
            color: Theme.of(context).brightness == Brightness.light
                ? Color(0xFF181818)
                : Colors.white,
            icon: AnimatedIcons.menu_close,
            progress: _animationController,
          ),
        ),
      );
    },);
  }

  void _showMenu() {
    _animationController.forward();

    OverlayEntry entry;

    entry = OverlayEntry(
      builder: (context) {
        return Material(
          type: MaterialType.transparency,
          child: Theme(
            data: Theme.of(context).copyWith(brightness: Brightness.dark),
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
          ),
        );
      },
    );

    Overlay.of(context).insert(entry);
  }
}
