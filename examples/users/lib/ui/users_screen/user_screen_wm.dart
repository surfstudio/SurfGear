import 'dart:math';

import 'package:example2/data/models/user_model.dart';
import 'package:example2/data/repo/users_repo.dart';
import 'package:flutter/widgets.dart';
import 'package:mwwm/mwwm.dart';

// ignore: prefer_mixin
class UserScreenWidgetModel extends WidgetModel with ChangeNotifier {
  final UsersRepo _usersRepo;

  String randomUserName = 'Loading...';

  List<User> _userList = [];

  UserScreenWidgetModel(
    WidgetModelDependencies baseDepencies,
    this._usersRepo,
  ) : super(baseDepencies);

  @override
  void onLoad() {
    super.onLoad();
    _fetchUsersFromServer();
  }

  void fetchRandomUserName() {
    final rnd = Random();
    final randomUserIndex = 0 + rnd.nextInt(_userList.length);
    randomUserName = _userList[randomUserIndex].name;
    notifyListeners();
  }

  Future<void> _fetchUsersFromServer() async {
    try {
      _userList = await _usersRepo.getUsers();
      fetchRandomUserName();

      notifyListeners();
      // ignore: avoid_catches_without_on_clauses, empty_catches
    } catch (e) {}
  }
}
