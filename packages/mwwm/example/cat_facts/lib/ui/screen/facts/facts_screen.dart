import 'dart:math' as math;

import 'package:cat_facts/data/facts/fact.dart';
import 'package:cat_facts/ui/screen/facts/facts_screen_wm.dart';
import 'package:mwwm/mwwm.dart';
import 'package:flutter/material.dart';
import 'package:relation/relation.dart';

class FactsScreen extends CoreMwwmWidget {
  FactsScreen({
    WidgetModelBuilder widgetModelBuilder = createFactsScreenWidgetModel,
  }) : super(widgetModelBuilder: widgetModelBuilder);

  @override
  State<StatefulWidget> createState() => _FactsSceenState();
}

class _FactsSceenState extends WidgetState<FactsScreenWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cats facts'),
        actions: [
          IconButton(
            icon: Transform.rotate(
              angle: math.pi / 6,
              child: Icon(Icons.brightness_3),
            ),
            onPressed: () {
              wm.switchTheme();
            },
          )
        ],
      ),
      body: StreamedStateBuilder<Iterable<Fact>>(
        streamedState: wm.facts,
        builder: (context, facts) {
          if (facts.isNotEmpty) {
            return ListView.builder(
              itemCount: facts.length,
              itemBuilder: (c, i) {
                final el = facts.elementAt(i);
                return ListTile(
                  title: Text(el.text),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
