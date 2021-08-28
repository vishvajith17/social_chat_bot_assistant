import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_chat_bot_assistant/models/user_model.dart';
import 'package:social_chat_bot_assistant/screens/Profile/components/profile_data_tile.dart';

class ProfileDataList extends StatefulWidget {
  @override
  _ProfileDataList createState() => _ProfileDataList();
}

class _ProfileDataList extends State<ProfileDataList> {
  @override
  Widget build(BuildContext context) {
    final clients = Provider.of<List<User>>(context) ?? [];

    return ListView.builder(
      itemCount: clients.length,
      itemBuilder: (context, index) {
        return ProfileDataTile(user: clients[index]);
      },
    );

    return Container();
  }
}
