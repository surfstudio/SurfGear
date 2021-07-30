import 'package:flutter/material.dart';
import 'package:mwwm_example/core/controllers/material_message_controller.dart';
import 'package:mwwm_example/core/error_handlers/standart_error_handler.dart';
import 'package:mwwm_example/features/auth/presentation/di/auth_provider.dart';
import 'package:mwwm_example/features/home/presentation/di/home_provider.dart';
import 'package:provider/provider.dart';

class InjectionContainer extends StatelessWidget {
  final Widget child;

  const InjectionContainer({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) => GlobalKey<NavigatorState>(),
        ),
        Provider(
          create: (_) => StandardErrorHandler(
            MaterialMessageController.from(context),
          ),
        ),
        const AuthProvider(),
        const HomeProvider(),
      ],
      child: child,
    );
  }
}
