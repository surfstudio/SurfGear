import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Widget for rendering Pokemon Types
class TypeDrawer extends StatelessWidget {
  final List<dynamic> types;

  TypeDrawer(this.types);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
          itemCount: types.length,
          itemBuilder: (ctx, i) {
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Chip(
                label: Text(types[i] as String, style: const TextStyle(fontWeight: FontWeight.bold),),
              ),
            );
          }),
    );
  }
}
