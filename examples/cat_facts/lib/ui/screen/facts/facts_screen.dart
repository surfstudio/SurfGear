import 'dart:math' as math;

import 'package:cat_facts/data/facts/fact.dart';
import 'package:cat_facts/ui/screen/facts/facts_screen_wm.dart';
import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:relation/relation.dart';

@immutable
class FactsScreen extends CoreMwwmWidget {
  const FactsScreen({
    Key? key,
  }) : super(key: key, widgetModelBuilder: createFactsScreenWidgetModel);

  @override
  State<StatefulWidget> createState() => _FactsSceenState();
}

class _FactsSceenState extends WidgetState<FactsScreenWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cats facts'),
        actions: [
          IconButton(
            icon: Transform.rotate(
              angle: math.pi / 6,
              child: const Icon(Icons.brightness_3),
            ),
            onPressed: () {
              wm.switchTheme();
            },
          ),
        ],
      ),
      body: StreamedStateBuilder<Iterable<Fact>>(
        streamedState: wm.facts,
        builder: (context, facts) {
          if (facts != null && facts.isNotEmpty) {
            return ListView.builder(
              itemCount: facts.length,
              itemBuilder: (c, i) {
                final el = facts.elementAt(i);

                return ListTile(title: Text(el.text ?? ''));
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
