import 'package:cat_facts/data/facts/fact.dart';
import 'package:cat_facts/data/theme/app_theme.dart';
import 'package:cat_facts/ui/screen/facts/facts_screen_wm.dart';
import 'package:flutter/material.dart';

///Отображение одного факта в списке
class FactListTile extends StatelessWidget {
  final FactsScreenWidgetModel wm;
  final Fact el;
  final int number;

  const FactListTile({
    required this.wm,
    required this.el,
    required this.number,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Fact $number',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 4),
              StreamBuilder<AppTheme?>(
                stream: wm.currentTheme(),
                builder: (_, snapshot) {
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
