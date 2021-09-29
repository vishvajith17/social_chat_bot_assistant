import 'package:flutter/material.dart';
import 'package:social_chat_bot_assistant/components/text_field_container.dart';
import 'package:social_chat_bot_assistant/constants.dart';

class RoundedInputField extends StatelessWidget {
  final dynamic initialValue;
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final ValueChanged<String> validator;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    Key key,
    this.initialValue,
    this.controller,
    this.hintText,
    this.icon = Icons.person,
    this.validator,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        initialValue: initialValue,
        controller: controller,
        validator: validator,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
