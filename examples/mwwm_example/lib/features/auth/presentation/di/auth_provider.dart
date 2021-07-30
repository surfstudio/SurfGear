import 'package:flutter/material.dart';
import 'package:mwwm_example/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:mwwm_example/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:mwwm_example/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:mwwm_example/features/auth/domain/repositories/auth_repository.dart';
import 'package:mwwm_example/features/auth/domain/usecases/authenticate_user.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class AuthProvider extends SingleChildStatelessWidget {
  const AuthProvider({Key? key}) : super(key: key);

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return MultiProvider(
      providers: [
        Provider<AuthLocalDataSource>(
          create: (_) => AuthLocalDataSourceImpl(),
        ),
        Provider<AuthRemoteDataSource>(
          create: (_) => AuthRemoteDataSourceImpl(),
        ),
        ProxyProvider2<AuthLocalDataSource, AuthRemoteDataSource,
            AuthRepository>(
          update: (_, localDataSource, remoteDataSource, __) =>
              AuthRepositoryImpl(
            remoteDataSource: remoteDataSource,
            localDataSource: localDataSource,
          ),
        ),
        ProxyProvider<AuthRepository, AuthenticateUser>(
          update: (_, repository, __) => AuthenticateUser(repository),
        ),
      ],
      child: child,
    );
  }
}
