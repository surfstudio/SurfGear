import 'package:flutter/cupertino.dart';
import 'package:surfgear_webpage/assets/images.dart';
import 'package:surfgear_webpage/assets/text.dart';
import 'package:surfgear_webpage/assets/text_styles.dart';
import 'package:surfgear_webpage/webpage/webpage_widget.dart';

/// Логотип в шапке
/// Вид логотипа расчитывается исходя из текущей ширины
class HeaderLogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > MEDIUM_SCREEN_WIDTH) {
      return _buildBigLogo();
    } else if (screenWidth > SMALL_SCREEN_WIDTH &&
        screenWidth <= MEDIUM_SCREEN_WIDTH) {
      return _buildMediumLogo();
    } else {
      return _buildSmallLogo();
    }
  }

  /// отрисовать большой логотип
  Widget _buildBigLogo() {
    return Padding(
      padding: const EdgeInsets.only(left: 64.0, right: 64.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            imgLogo,
          ),
          SizedBox(width: 64),
          Text(
            logoText,
            style: white42,
          ),
        ],
      ),
    );
  }

  /// отрисовать средний логотип
  Widget _buildMediumLogo() {
    return Padding(
      padding: const EdgeInsets.only(left: 64.0, right: 64.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              imgLogo,
            ),
            Text(
              logoText,
              style: white42,
            ),
          ],
        ),
      ),
    );
  }

  /// отрисовать маленький логотип
  Widget _buildSmallLogo() {
    return Padding(
      padding: const EdgeInsets.only(left: 64.0, right: 64.0),
      child: Column(
        children: <Widget>[
          Image.asset(
            imgLogo,
            width: 492.0,
            height: 262.0,
          ),
          Text(
            logoText,
            style: white28,
          ),
        ],
      ),
    );
  }
}
