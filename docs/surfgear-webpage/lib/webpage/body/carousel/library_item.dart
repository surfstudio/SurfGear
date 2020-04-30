import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:surfgear_webpage/webpage/webpage_widget.dart';

/// Widget carousel item
class LibraryItem extends StatelessWidget {
  /// Title
  final String title;

  /// Image path
  final String imagePath;

  LibraryItem({
    this.title,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= SMALL_SCREEN_WIDTH) {
      return _buildSmallItem();
    } else {
      return _buildMediumAndBigItem();
    }
  }

  Widget _buildSmallItem() {
    return Column(
      children: <Widget>[
        Image.asset(
          imagePath,
          width: 162,
          height: 221,
        ),
        SizedBox(height: 8.0),
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.sourceCodePro(
            color: Colors.black,
            fontSize: 18.0,
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildMediumAndBigItem() {
    return Column(
      children: <Widget>[
        Image.asset(
          imagePath,
          width: 162,
          height: 221,
        ),
        SizedBox(height: 8.0),
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.sourceCodePro(
            color: Colors.black,
            fontSize: 24.0,
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.normal,
          ),
        ),
      ],
    );
  }
}
