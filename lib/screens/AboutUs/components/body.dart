import 'package:flutter/material.dart';
import 'package:social_chat_bot_assistant/screens/AboutUs/components/background.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("CSE GROUP 38"),
            Text("SOCIAL INQUIRY CHAT-BOT MOBILE APPLICATION"),
            Text("DEVELOPERS:"),
            Text("H.G.M.VISHVAJITH"),
            Text("V.SALINY"),
            Text("V.VIPOOSHAN"),
            SizedBox(height: size.height * 0.03),
          ],
        ),
      ),
    );
  }
}
