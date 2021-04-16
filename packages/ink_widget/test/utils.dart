import 'package:flutter/material.dart';

Widget wrapMyWidget(Widget widgetForWrap) =>
    MaterialApp(home: Scaffold(body: Stack(children: [widgetForWrap])));
