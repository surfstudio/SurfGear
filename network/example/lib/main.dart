import 'package:flutter/material.dart';
import 'package:name_generator/interactor/name_generator/name_generator_interactor.dart';
import 'package:name_generator/interactor/name_generator/repository/name_generator_repository.dart';
import 'package:name_generator/interactor/network/status_mapper.dart';
import 'package:name_generator/ui/app/app.dart';
import 'package:network/network.dart';

void main() {
  NameGeneratorRepository repository = NameGeneratorRepository(_initHttp());
  NameGeneratorInteractor interactor = NameGeneratorInteractor(repository);

  runApp(App(interactor));
}

RxHttp _initHttp() {
  var dioHttp = DioHttp(
    config: HttpConfig(
      'https://uinames.com/api/?ext',
      Duration(seconds: 30),
    ),
    errorMapper: DefaultStatusMapper(),
  );
  return RxHttpDelegate(dioHttp);
}
