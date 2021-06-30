import 'package:cat_facts/data/facts/fact.dart';
import 'package:cat_facts/data/theme/app_theme.dart';
import 'package:cat_facts/ui/screen/facts/facts_screen_wm.dart';
import 'package:flutter/material.dart';

class FactListTile extends StatelessWidget {
  final FactsScreenWidgetModel wm;
  final Fact el;
  final int position;

  const FactListTile({
    required this.wm,
    required this.el,
    required this.position,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Fact $position',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 4),
              StreamBuilder<AppTheme?>(
                stream: wm.currentTheme(),
                builder: (context, snapshot) {
                  return Expanded(
                    child: Divider(
                      color: (snapshot.data == AppTheme.light)
                          ? Colors.black
                          : Colors.white,
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(el.content ?? ''),
        ],
      ),
    );
  }
}
