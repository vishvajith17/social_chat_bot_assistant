import 'package:flutter/material.dart';
import 'package:social_chat_bot_assistant/models/user_model.dart';

class ProfileDataTile extends StatelessWidget {
  final User user;

  const ProfileDataTile({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown,
          ),
          title: Text(user.first_name),
        ),
      ),
    );
  }
}
