import 'package:flutter/material.dart';
import 'package:social_chat_bot_assistant/components/text_field_container.dart';
import 'package:social_chat_bot_assistant/constants.dart';

class RoundedPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String> validator;
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    Key key,
    this.controller,
    this.hintText,
    this.validator,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        obscureText: true,
        controller: controller,
        validator: validator,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: kPrimaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
