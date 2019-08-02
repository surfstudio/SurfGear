import 'package:flutter/material.dart' show NavigatorState;
import 'package:mwwm/mwwm.dart';
import 'package:name_generator/domain/User.dart';
import 'package:name_generator/interactor/name_generator/name_generator_interactor.dart';

/// WidgetModel для экрана счетчика
class NameGeneratorWidgetModel extends WidgetModel {
  List<User> _userList = [];

  final NavigatorState navigator;

  final NameGeneratorInteractor _nameGeneratorInteractor;

  final Action getUserAction = Action();
  final StreamedState<List<User>> listState = StreamedState([]);

  NameGeneratorWidgetModel(
    WidgetModelDependencies dependencies,
    this.navigator,
    this._nameGeneratorInteractor,
  ) : super(dependencies);

  @override
  void onLoad() {
    _listenToActions();
    _listenToStreams();
    super.onLoad();
  }

  void _listenToStreams() {}

  void _listenToActions() {
    bind(
      getUserAction,
      (_) {
        subscribe(_nameGeneratorInteractor.getCard(), (user) {
          _userList = listState.value;
          _userList.add(user);
          listState.accept(_userList);
        });
      },
    );
  }
}
