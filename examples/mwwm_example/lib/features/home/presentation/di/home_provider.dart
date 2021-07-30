import 'package:flutter/material.dart';
import 'package:mwwm_example/features/auth/domain/repositories/auth_repository.dart';
import 'package:mwwm_example/features/home/data/datarources/home_remote_data_source.dart';
import 'package:mwwm_example/features/home/data/repositories/home_repository_impl.dart';
import 'package:mwwm_example/features/home/domain/repositories/home_repository.dart';
import 'package:mwwm_example/features/home/domain/usecases/get_home_data.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class HomeProvider extends SingleChildStatelessWidget {
  const HomeProvider({Key? key}) : super(key: key);

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return MultiProvider(
      providers: [
        Provider<HomeRemoteDataSource>(
          create: (_) => HomeRemoteDataSourceImpl(),
        ),
        ProxyProvider<HomeRemoteDataSource, HomeRepository>(
          update: (_, homeRemoteDataSource, __) => HomeRepositoryImpl(
            homeRemoteDataSource: homeRemoteDataSource,
          ),
        ),
        ProxyProvider2<AuthRepository, HomeRepository, GetHomeData>(
          update: (_, authRepository, homeRepository, __) => GetHomeData(
            authRepository: authRepository,
            homeRepository: homeRepository,
          ),
        ),
      ],
      child: child,
    );
  }
}
