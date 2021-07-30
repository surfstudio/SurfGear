import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:mwwm_example/features/auth/presentation/wms/auth_screen_wm.dart';

class AuthScreen extends CoreMwwmWidget<AuthScreenWidgetModel> {
  const AuthScreen({Key? key})
      : super(
          key: key,
          widgetModelBuilder: authScreenWidgetModelBuilder,
        );
  @override
  WidgetState<CoreMwwmWidget<AuthScreenWidgetModel>, AuthScreenWidgetModel>
      createWidgetState() {
    return _AuthScreenState();
  }
}

class _AuthScreenState extends WidgetState<AuthScreen, AuthScreenWidgetModel> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LoginPage'),
      ),
      body: StreamBuilder<bool>(
        stream: wm.isLoading,
        builder: (context, snapshot) {
          final isLoading = snapshot.data ?? false;

          if (isLoading) {
            return const CircularProgressIndicator();
          }
          return Column(
            children: [
              const Text('Login'),
              TextField(
                controller: wm.loginController,
              ),
              const Text('Password'),
              TextField(
                controller: wm.passwordController,
              ),
              TextButton(
                onPressed: wm.authenticate,
                child: const Text('Login'),
              ),
            ],
          );
        },
      ),
    );
  }
}
