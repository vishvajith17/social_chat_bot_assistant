import 'package:flutter/material.dart';
import 'package:social_chat_bot_assistant/components/rounded_button.dart';
import 'package:social_chat_bot_assistant/screens/DomainPage/components/background.dart';
import 'package:social_chat_bot_assistant/screens/TransportDomain/transport_domain_screen.dart';
import 'package:social_chat_bot_assistant/screens/TelecommunicationDomain/telecommunication_domain_screen.dart';
import 'package:social_chat_bot_assistant/screens/TelecommunicationDomain/bot_chat_screen.dart';
import 'package:flutter_svg/svg.dart';

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
              text: "Public Transport",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return TransportDomainScreen();
                    },
                  ),
                );
              },
            ),
            SizedBox(height: size.height * 0.03),
            RoundedButton(
              text: "Telecommunication",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return TelecommunicationDomainScreen();
                    },
                  ),
                );
              },
            ),
            SizedBox(height: size.height * 0.03),
            RoundedButton(
              text: "Electricity",
              press: () {},
            ),
            SizedBox(height: size.height * 0.03),
          ],
        ),
      ),
    );
  }
}
