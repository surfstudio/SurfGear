import 'dart:math';

import 'package:example2/data/models/user_model.dart';
import 'package:example2/data/repo/users_repo.dart';
import 'package:flutter/widgets.dart';
import 'package:mwwm/mwwm.dart';

class UserScreenWidgetModel extends WidgetModel with ChangeNotifier {
  final UsersRepo _usersRepo;

  List<User> _userList = [];
  String randomUserName = "Loading...";

  UserScreenWidgetModel(WidgetModelDependencies baseDepencies, this._usersRepo,
      {builder})
      : super(baseDepencies);

  @override
  void onLoad() {
    super.onLoad();
    _fetchUsersFromServer();
  }

  Future<void> _fetchUsersFromServer() async {
    try {
      _userList = await _usersRepo.getUsers();
      fetchRandomUserName();

      notifyListeners();
    } catch (e) {}
  }

  void fetchRandomUserName() {
    var rnd = Random();
    int randomUserIndex = 0 + rnd.nextInt(_userList.length);
    randomUserName = _userList[randomUserIndex].name;
    notifyListeners();
  }
}
