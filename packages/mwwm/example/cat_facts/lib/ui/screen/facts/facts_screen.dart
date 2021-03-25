import 'dart:math' as math;

import 'package:cat_facts/data/app/app_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class FactsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appModel = Provider.of<AppModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Facts Screen'),
        actions: [
          IconButton(
            icon: Transform.rotate(
              angle: math.pi / 6,
              child: Icon(Icons.brightness_3),
            ),
            onPressed: () {
              appModel.changeTheme();
            },
          )
        ],
      ),
    );
  }
}
