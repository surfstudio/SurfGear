import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Widget for top panel information
class QuickInfoPanel extends StatelessWidget {
  final String? height;
  final String? species;
  final String? imageUrl;

  QuickInfoPanel({this.height, this.imageUrl, this.species});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.network(imageUrl as String, height: 128.0,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text("Height:", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(height as String),
            const Text("Species:", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(species as String),
          ],
        )
      ],
    );
  }
}
