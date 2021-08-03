import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mwwm/mwwm.dart';
import 'package:mwwm_example/core/controllers/material_message_controller.dart';
import 'package:mwwm_example/core/error_handlers/standart_error_handler.dart';
import 'package:mwwm_example/features/auth/domain/usecases/authenticate_user.dart';
import 'package:mwwm_example/features/home/presentation/screens/home_screen_route.dart';
import 'package:provider/provider.dart';

AuthScreenWidgetModel authScreenWidgetModelBuilder(BuildContext context) {
  final messageController = MaterialMessageController.from(context);
  final errorHandler = StandardErrorHandler(messageController);

  return AuthScreenWidgetModel(
    WidgetModelDependencies(
      errorHandler: errorHandler,
    ),
    authenticateUser: Provider.of<AuthenticateUser>(context, listen: false),
    navigator: Navigator.of(context),
  );
}

class AuthScreenWidgetModel extends WidgetModel {
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  late final AuthenticateUser authenticateUser;
  late final NavigatorState navigator;

  final _isLoadingController = StreamController<bool>();

  Stream<bool> get isLoading => _isLoadingController.stream;

  AuthScreenWidgetModel(
    WidgetModelDependencies baseDependencies, {
    required this.authenticateUser,
    required this.navigator,
  }) : super(baseDependencies);

  @override
  void onLoad() {
    super.onLoad();
    _isLoadingController.add(false);
  }

  @override
  void dispose() {
    _isLoadingController.close();
    super.dispose();
  }

  Future<void> authenticate() async {
    if (loginController.text == '' || passwordController.text == '') {
      //Индикация обязательных полей
      throw Exception('Fill fields');
    }

    try {
      _isLoadingController.add(true);

      await authenticateUser.call(Params(
        login: loginController.text,
        password: passwordController.text,
      ));
      await navigator.pushReplacement(HomeScreenRoute());
    } catch (e) {
      handleError(e);
    } finally {
      _isLoadingController.add(false);
    }
  }
}
