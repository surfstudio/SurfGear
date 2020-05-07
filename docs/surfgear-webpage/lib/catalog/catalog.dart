import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:surfgear_webpage/assets/images.dart';
import 'package:surfgear_webpage/catalog/modules.dart';
import 'package:surfgear_webpage/components/menu.dart';
import 'package:surfgear_webpage/const.dart';
import 'package:surfgear_webpage/main.dart';
import 'package:surfgear_webpage/webpage/common/widgets.dart';
import 'package:surfgear_webpage/webpage/webpage_widget.dart';
import 'package:url_launcher/url_launcher.dart';

const _surfBlue = Color(0xFF000240);

class Catalog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: GestureDetector(
          onVerticalDragStart: (_) {},
          child: Column(
            children: <Widget>[
              _Header(),
              _List(),
              SizedBox(height: 630.0),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final logoAndText = <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 56.0,
          vertical: 32.0,
        ),
        child: Clickable(
          onClick: () => Navigator.of(context).pushNamed(Router.main),
          child: Image.asset(imgLogoBlue),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 56.0,
          vertical: 32.0,
        ),
        child: AutoSizeText(
          'Каталог модулей',
          textAlign: TextAlign.center,
          maxLines: 2,
          style: GoogleFonts.rubik(
            color: _surfBlue,
            fontSize: 42.0,
          ),
        ),
      ),
    ];

    return ConstrainedBox(
      constraints: BoxConstraints.expand(height: 650.0),
      child: Column(
        children: <Widget>[
          Menu(),
          Expanded(
            child: Center(
              child: MediaQuery.of(context).size.width > MEDIUM_SCREEN_WIDTH
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: logoAndText,
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: logoAndText,
                    ),
            ),
          )
        ],
      ),
    );
  }
}

class _List extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        for (var i = 0; i < modules.length; i++)
          _ListTile(
            module: modules[i],
            isOdd: i.isOdd,
          ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 120.0),
            child: _RepositoryButton(),
          ),
        ),
      ],
    );
  }
}

class _ListTile extends StatelessWidget {
  final Module module;
  final bool isOdd;

  _ListTile({
    Key key,
    @required this.module,
    this.isOdd = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: isOdd ? Color(0xFFF2F2F2) : Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              flex: 2,
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(left: 32.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Clickable(
                        onClick: () => launch(module.link),
                        child: Text(
                          module.name,
                          textAlign: TextAlign.right,
                          style: GoogleFonts.raleway(
                            fontWeight: FontWeight.w300,
                            fontSize: 24.0,
                          ),
                        ),
                      ),
                      if (screenWidth <= SMALL_SCREEN_WIDTH)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: _ModuleStatusBadge(
                            status: module.status,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            if (screenWidth >= SMALL_SCREEN_WIDTH)
              SizedBox(
                width: screenWidth >= MEDIUM_SCREEN_WIDTH ? 360.0 : 180.0,
                child: Center(
                  child: _ModuleStatusBadge(
                    status: module.status,
                  ),
                ),
              )
            else
              SizedBox(width: 60.0),
            Flexible(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(right: 32.0),
                child: SizedBox(
                  width: 630,
                  child: Text(
                    module.description,
                    style: GoogleFonts.raleway(
                      fontSize: 24.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ModuleStatusBadge extends StatelessWidget {
  final ModuleStatus status;

  _ModuleStatusBadge({
    Key key,
    @required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String text;
    Color color;

    if (status == ModuleStatus.alpha) {
      text = 'alpha';
      color = Color(0xFFC61207);
    } else if (status == ModuleStatus.beta) {
      text = 'beta';
      color = Color(0xFFC89000);
    } else if (status == ModuleStatus.release) {
      text = 'release';
      color = Color(0xFF17A700);
    } else {
      text = 'surf';
      color = Color(0xFF00638E);
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 2.0,
        ),
        child: Text(
          text,
          style: GoogleFonts.raleway(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _RepositoryButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WebButton(
      onPressed: () => launch(packagesUrl),
      buttonBuilder: (context, isHovering) {
        return DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(color: _surfBlue),
            color: isHovering ? _surfBlue : Colors.transparent,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 18.0,
              horizontal: 40.0,
            ),
            child: Text(
              'Перейти в репозиторий',
              style: GoogleFonts.comfortaa(
                color: isHovering ? Colors.white : _surfBlue,
                fontSize: 18.0,
              ),
            ),
          ),
        );
      },
    );
  }
}
