import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:surfgear_webpage/webpage/webpage_widget.dart';

/// Элемент карусели виджетов
/// https://www.figma.com/file/FTTXzwb6zPFZtOhGK0PAKl/Untitled?node-id=13%3A12
class LibraryItem extends StatelessWidget {
  /// Заголовок
  final String title;

  /// Путь до картинки
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

  /// Отрисовать маленький итем
  Widget _buildSmallItem() {
    return Column(
      children: <Widget>[
        Image.asset(imagePath),
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

  /// Отрисовать средний и большой итем
  Widget _buildMediumAndBigItem() {
    return Column(
      children: <Widget>[
        Image.asset(imagePath),
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
