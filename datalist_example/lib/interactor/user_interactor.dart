import 'package:datalist/datalist.dart';
import 'package:datalist_example/interactor/user_repository.dart';

import 'data/user.dart';

class UserInteractor {
  UserRepository _repository;

  UserInteractor(this._repository);

  Future<OffsetDataList<User>> getUserList(int offset, int limit) async =>
      _repository.getUserList2(offset, limit);
}
