import 'package:flutter/material.dart';
import 'package:social_chat_bot_assistant/screens/Help/components/background.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("PUBLIC TRANSPORT"),
            Text("lost something section: "),
            Text("use Lost keyword to inquiry about lost item"),
            Text("use Log keyword to check your previous inquiries"),
            Text("use Exit keyword to end chat"),
            SizedBox(height: size.height * 0.03),
            Text("PUBLIC TRANSPORT"),
            Text("complaint section: "),
            Text("use Complaint keyword to inquiry about lost item"),
            Text("use Log keyword to check your previous inquiries"),
            Text("use Exit keyword to end chat"),
            SizedBox(height: size.height * 0.03),
            Text("PUBLIC TRANSPORT"),
            Text("schedule section: "),
            Text("use Schedule keyword to inquiry about lost item"),
            Text("use Exit keyword to end chat"),
            SizedBox(height: size.height * 0.03),
            Text("ELECTRICITY"),
            Text("schedule section: "),
            SizedBox(height: size.height * 0.03),
            Text("TELECOMMUNICATION"),
            Text("schedule section: "),
            SizedBox(height: size.height * 0.03),
          ],
        ),
      ),
    );
  }
}
