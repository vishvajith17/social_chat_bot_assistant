import 'package:flutter/material.dart';
import 'package:social_chat_bot_assistant/screens/Welcome/components/body.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CHATTY"),
      ),
      body: Body(),
    );
  }
}
