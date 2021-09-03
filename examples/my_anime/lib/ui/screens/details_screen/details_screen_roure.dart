import 'package:flutter/material.dart';
import 'package:my_anime/ui/app/app_component.dart';
import 'package:my_anime/ui/screens/details_screen/details_screen.dart';
import 'package:my_anime/ui/screens/details_screen/details_screen_component.dart';
import 'package:surf_injector/surf_injector.dart';

class DetailsScreenRoute extends MaterialPageRoute<void> {
  DetailsScreenRoute(int id)
      : super(
          builder: (context) => Injector(
            component: DetailsScreenComponent(
              id,
              Injector.of<AppComponent>(context).component.animeInteractor,
            ),
            builder: (_) => const DetailsScreen(),
          ),
        );
}
