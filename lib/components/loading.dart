import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:social_chat_bot_assistant/constants.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryColor,
      child: Center(
        child: SpinKitChasingDots(
          color: kPrimaryLightColor,
          size: 50.0,
        ),
      ),
    );
  }
}
