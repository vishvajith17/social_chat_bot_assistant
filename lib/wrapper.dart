import 'package:flutter/material.dart';
import 'package:social_chat_bot_assistant/screens/DomainPage/domain_screen.dart';
import 'package:social_chat_bot_assistant/models/user_model.dart';
import 'package:social_chat_bot_assistant/screens/Welcome/welcome_screen.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user == null) {
      return WelcomeScreen();
    } else {
      return DomainScreen();
    }
  }
}
