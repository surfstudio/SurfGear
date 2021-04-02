import 'package:flutter/material.dart';
import 'package:surf_controllers/surf_controllers.dart';

enum ExampleDialogType {
  text,
}

class ExampleDialogData extends DialogData {
  ExampleDialogData({
    this.title,
    this.subtitle,
  });

  final String title;
  final String subtitle;
}

class ExampleDialog extends StatelessWidget {
  const ExampleDialog({
    @required this.data,
    Key key,
  }) : super(key: key);

  final ExampleDialogData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green[200],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            data.title,
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            data.subtitle,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
