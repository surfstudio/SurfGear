import 'package:example2/data/models/user_model.dart';
import 'package:example2/data/repo/users_repo.dart';
import 'package:flutter/widgets.dart';
import 'package:mwwm/mwwm.dart';

class UserScreenWidgetModel extends WidgetModel with ChangeNotifier {
  final UsersRepo _usersRepo;

  List<User> userList = [];

  UserScreenWidgetModel(WidgetModelDependencies baseDepencies, this._usersRepo)
      : super(baseDepencies);

  Future<void> _fetchUsersFromServer() async {
    userList = await _usersRepo.getUsers();
    notifyListeners();
  }
}
