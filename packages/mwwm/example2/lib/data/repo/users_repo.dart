import 'package:example2/data/models/user_model.dart';
import 'package:example2/data/storage/api_client.dart';

class UsersRepo {
  final ApiClient apiClient;

  UsersRepo({required this.apiClient});

  Future<List<User>> getUsers() async {
    var usersFromApi = await apiClient.fecthUsers();
    usersFromApi.sort((a, b) {
      return a.id.compareTo(b.id);
    });
    return usersFromApi;
  }
}
