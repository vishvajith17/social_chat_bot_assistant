import 'package:flutter/material.dart';
import 'package:social_chat_bot_assistant/components/rounded_button.dart';
import 'package:social_chat_bot_assistant/screens/DomainPage/components/background.dart';
import 'package:social_chat_bot_assistant/screens/TransportDomain/lost_something.dart';
import 'package:social_chat_bot_assistant/screens/TransportDomain/lost_something_screen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:social_chat_bot_assistant/screens/TransportDomain/transport_complaint.dart';
import 'package:social_chat_bot_assistant/screens/TransportDomain/transport_complaint_screen.dart';
import 'package:social_chat_bot_assistant/screens/TransportDomain/transport_schedule.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedButton(
              text: "Complaint",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return BotChatComplaint();
                    },
                  ),
                );
              },
            ),
            SizedBox(height: size.height * 0.03),
            RoundedButton(
              text: "Lost Something?",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return BotChat();
                    },
                  ),
                );
              },
            ),
            SizedBox(height: size.height * 0.03),
            RoundedButton(
              text: "Need Schedule",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return BotChatSchedule();
                    },
                  ),
                );
              },
            ),
            SizedBox(height: size.height * 0.03),
          ],
        ),
      ),
    );
  }
}
