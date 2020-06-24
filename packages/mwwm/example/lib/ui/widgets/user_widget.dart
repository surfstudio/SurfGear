import 'package:flutter/material.dart';
import 'package:mwwm_github_client/data/owner.dart';

class UserWidget extends StatelessWidget {
  UserWidget({
    @required this.user,
    Key key,
  })  : assert(user != null),
        super(key: key);

  final Owner user;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Column(
          children: [
            Image.network(
              user.avatarUrl,
              height: 200,
            ),
            const SizedBox(height: 8),
            Text(
              user.login,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
