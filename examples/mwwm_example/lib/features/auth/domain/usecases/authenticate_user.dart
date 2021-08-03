import 'package:equatable/equatable.dart';
import 'package:mwwm_example/core/usecase/usecase.dart';
import 'package:mwwm_example/features/auth/domain/entities/auth_data.dart';
import 'package:mwwm_example/features/auth/domain/repositories/auth_repository.dart';

class AuthenticateUser implements UseCase<AuthData, Params> {
  final AuthRepository _repository;

  AuthenticateUser(this._repository);

  @override
  Future<AuthData> call(Params params) {
    return _repository.authenticate(
      login: params.login,
      password: params.password,
    );
  }
}

class Params extends Equatable {
  final String login;
  final String password;

  @override
  List<Object?> get props => [login, password];

  Params({
    required this.login,
    required this.password,
  });
}
