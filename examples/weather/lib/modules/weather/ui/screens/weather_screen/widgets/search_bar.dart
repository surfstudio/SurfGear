import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:relation/relation.dart';
import 'package:weather/modules/weather/ui/decorations/input_text_decoration.dart';
import 'package:weather/modules/weather/ui/res/ui_constants.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
    required this.inputPadding,
    required this.findCityByGeoAction,
    required this.textEditionController,
    required this.fetchInputAction,
  }) : super(key: key);

  final double inputPadding;
  final VoidAction findCityByGeoAction;
  final ExtendedTextEditingController textEditionController;
  final VoidAction fetchInputAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          inputPadding, standardPadding, inputPadding, standardPadding),
      child: Row(
        children: [
          GestureDetector(
            child: FaIcon(FontAwesomeIcons.mapMarkerAlt, size: 40),
            onTap: findCityByGeoAction,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: TextFormField(
                style: TextStyle(fontSize: 20),
                cursorColor: Colors.white,
                decoration: inputTextDecoration('Enter City Name'),
                controller: textEditionController,
              ),
            ),
          ),
          GestureDetector(
            child: FaIcon(FontAwesomeIcons.searchLocation, size: 40),
            onTap: fetchInputAction,
          ),
        ],
      ),
    );
  }
}
