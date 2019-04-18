import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_template/ui/res/colors.dart';
import 'package:flutter_template/ui/res/strings.dart';
import 'package:flutter_template/ui/res/text_styles.dart';

/// плейсхолдер для состояния ошибки
class ErrorPlaceHolder extends StatelessWidget {
  final Function onReload;

  const ErrorPlaceHolder({Key key, this.onReload}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            errorPlaceholderTitleText,
            style: textMedium16,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 11.0),
            child: Text(
              errorPlaceholderSubtitleText,
              style: textMedium16Secondary,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 80.0),
            child: RaisedButton(
              elevation: 0.0,
              color: secondaryBtnColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              onPressed: onReload,
              child: Text(
                errorPlaceholderBtnText,
                style: textRegular14Red,
              ),
            ),
          )
        ],
      ),
    );
    ;
  }
}
