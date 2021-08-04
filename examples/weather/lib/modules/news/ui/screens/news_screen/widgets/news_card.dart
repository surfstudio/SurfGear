import 'package:flutter/material.dart';
import 'package:weather/modules/weather/ui/res/ui_constants.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(standardPadding),
      child: Card(
        child: Text(
          'TEST TEST TEST',
          style: TextStyle(color: Colors.black),
        ),
        color: Colors.white,
      ),
    );
  }
}
