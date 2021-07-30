import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mwwm/mwwm.dart';
import 'package:mwwm_example/core/error_handlers/standart_error_handler.dart';
import 'package:mwwm_example/core/usecase/usecase.dart';
import 'package:mwwm_example/features/home/domain/entities/home_data.dart';
import 'package:mwwm_example/features/home/domain/usecases/get_home_data.dart';
import 'package:provider/provider.dart';

HomeScreenWidgetModel homeScreenWidgetModelBuilder(BuildContext context) {
  return HomeScreenWidgetModel(
    WidgetModelDependencies(
      errorHandler: Provider.of<StandardErrorHandler>(context, listen: false),
    ),
    getHomeData: Provider.of<GetHomeData>(context, listen: false),
  );
}

class HomeScreenWidgetModel extends WidgetModel {
  final GetHomeData getHomeData;

  final _isLoadingController = StreamController<bool>();

  HomeScreenWidgetModel(
    WidgetModelDependencies baseDependencies, {
    required this.getHomeData,
  }) : super(baseDependencies);

  @override
  void onLoad() {
    super.onLoad();
    getData();
    _isLoadingController.add(false);
  }

  @override
  void dispose() {
    _isLoadingController.close();
    super.dispose();
  }

  Future<HomeData> getData() {
    return getHomeData.call(NoParams());
  }
}
