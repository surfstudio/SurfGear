import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tabnavigator/tabnavigator.dart';

typedef NavElementBuilder = Widget Function(bool isSelected);

/// Bottom navigation bar widget.
class BottomNavBar extends StatefulWidget {
  final StreamSink<TabType> selected;
  final TabType initType;
  final Map<TabType, NavElementBuilder> elements;

  const BottomNavBar({
    Key key,
    @required this.selected,
    @required this.initType,
    @required this.elements,
  }) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  TabType _currentType;

  @override
  void initState() {
    super.initState();

    _currentType = widget.initType;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _buildElements(),
    );
  }

  List<Widget> _buildElements() {
    List<Widget> widgets = [];

    widget.elements.forEach(
      (tabType, builder) => widgets.add(
        Expanded(child: _buildElement(builder, tabType)),
      ),
    );

    return widgets;
  }

  Widget _buildElement(NavElementBuilder builder, TabType tabType) {
    return InkWell(
      child: builder(tabType == _currentType),
      onTap: () {
        setState(() {
          _currentType = tabType;
          widget.selected.add(tabType);
        });
      },
    );
  }
}
