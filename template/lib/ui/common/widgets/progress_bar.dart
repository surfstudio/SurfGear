

import 'package:flutter/material.dart';
import 'package:flutter_template/ui/res/colors.dart';

///Custom progress syling by colorAccent and sizes 44x44
class ProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44.0,
      height: 44.0,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(colorAccent),
      ),
    );
  }
}
