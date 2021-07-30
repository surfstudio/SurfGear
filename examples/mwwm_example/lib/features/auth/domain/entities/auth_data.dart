import 'package:equatable/equatable.dart';

class AuthData extends Equatable {
  final String accessToken;

  @override
  List<Object?> get props => [accessToken];

  const AuthData({
    required this.accessToken,
  });
}
