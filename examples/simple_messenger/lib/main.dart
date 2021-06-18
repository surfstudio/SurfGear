import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:provider/provider.dart';

import 'interactor/message/message_interactor.dart';
import 'interactor/message/repository/message_repository.dart';
import 'ui/screens/choose_name/pick_name_screen.dart';
import 'utils/default_error_handler.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider(
            create: (_) => WidgetModelDependencies(
              errorHandler: DefaultErrorHandler(),
            ),
          ),
          Provider(
            create: (_) => MessageInteractor(
              repo: MessageRepository(FirebaseFirestore.instance),
            ),
          ),
        ],
        child: MaterialApp(
          home: PickNameScreen(),
        ),
      );
}
