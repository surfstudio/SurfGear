import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:relation/relation.dart';
import 'package:todos/models/filter_type.dart';
import 'package:todos/ui/widgets/filter_button/filter_button_i18n.dart';
import 'package:todos/ui/widgets/filter_button/filter_button_wm.dart';

class FilterButton extends CoreMwwmWidget {
  FilterButton() : super(widgetModelBuilder: (context) => FilterButtonWM(context));

  @override
  State<StatefulWidget> createState() => _FilterButtonState();
}

class _FilterButtonState extends WidgetState<FilterButtonWM> {
  @override
  Widget build(BuildContext context) => StreamedStateBuilder<FilterType>(
        streamedState: wm.currentFilterState,
        builder: (_, selectedFilter) => PopupMenuButton<FilterType>(
          icon: Icon(Icons.filter_list),
          onSelected: wm.selectFilter,
          itemBuilder: (BuildContext context) => [
            CheckedPopupMenuItem<FilterType>(
              value: FilterType.all,
              checked: FilterType.all == selectedFilter,
              child: Text(FilterButtonI18n.showAll),
            ),
            CheckedPopupMenuItem<FilterType>(
              value: FilterType.active,
              checked: FilterType.active == selectedFilter,
              child: Text(FilterButtonI18n.showActive),
            ),
            CheckedPopupMenuItem<FilterType>(
              value: FilterType.completed,
              checked: FilterType.completed == selectedFilter,
              child: Text(FilterButtonI18n.showCompleted),
            ),
          ],
        ),
      );
}
