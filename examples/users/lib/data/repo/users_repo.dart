import 'package:example2/data/models/user_model.dart';
import 'package:example2/data/storage/api_client.dart';

class UsersRepo {
  final ApiClient apiClient;

  UsersRepo({required this.apiClient});

  Future<List<User>> getUsers() async {
    final usersFromApi = await apiClient.fecthUsers();
    return usersFromApi;
  }
}
