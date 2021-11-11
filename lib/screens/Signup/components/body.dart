import 'package:flutter/material.dart';
import 'package:social_chat_bot_assistant/components/already_have_an_account_acheck.dart';
import 'package:social_chat_bot_assistant/components/loading.dart';
import 'package:social_chat_bot_assistant/components/rounded_button.dart';
import 'package:social_chat_bot_assistant/components/rounded_input_field.dart';
import 'package:social_chat_bot_assistant/components/rounded_password_field.dart';
import 'package:social_chat_bot_assistant/screens/Login/login_screen.dart';
import 'package:social_chat_bot_assistant/screens/Signup/components/background.dart';
import 'package:social_chat_bot_assistant/screens/Signup/components/or_divider.dart';
import 'package:social_chat_bot_assistant/screens/Signup/components/social_icon.dart';
import 'package:flutter_svg/svg.dart';
import 'package:social_chat_bot_assistant/services/auth_service.dart';

class FirstNameFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'First name can\'t be empty' : null;
  }
}

class LastNameFieldValidator {
  static String validate(String value) {
    return  value.isEmpty ? 'Last name can\'t be empty' : null;
  }
}

class DoBFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'DoB can\'t be empty' : null;
  }
}

class NICFieldValidator {
  static String validate(String value) {
    return  value.isEmpty ? 'NIC can\'t be empty' : null;
  }
}

class MobileFieldValidator {
  static String validate(String value) {
    return value.length < 10 || value.length > 10
                                  ? 'Enter a phone number with 10 numbers'
                                  : null;
  }
}

class EmailFieldValidator {
  static String validate(String value) {
    return  value.isEmpty ? 'Enter an valid email' : null;
  }
}

class PasswordFieldValidator {
  static String validate(String value) {
    return value.length < 6 ? 'Enter a password 6+ chars long' : null;
  }
}
                              
class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;
  String firstName = "";
  String lastName = "";
  String birthDay = "";
  String nic = "";
  String phoneNumber = "";
  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return loading
        ? Loading()
        : Background(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20.0),
                        Text(
                          'REGISTER',
                          style: TextStyle(fontSize: 25, fontFamily: 'Lobster'),
                        ),
                        SizedBox(height: 20.0),
                        RoundedInputField(
                          hintText: "First Name",
                          validator: (value) =>FirstNameFieldValidator.validate(value),
                          onChanged: (value) {
                            setState(() {
                              firstName = value;
                            });
                          },
                        ),
                        RoundedInputField(
                          hintText: "Last Name",
                          validator: (value) =>LastNameFieldValidator.validate(value),
                          onChanged: (value) {
                            setState(() {
                              lastName = value;
                            });
                          },
                        ),
                        RoundedInputField(
                          hintText: "Birth Day (YYYY/MM/DD)",
                          icon: Icons.cake,
                          validator: (value) =>DoBFieldValidator.validate(value),
                          onChanged: (value) {
                            setState(() {
                              birthDay = value;
                            });
                          },
                        ),
                        RoundedInputField(
                          hintText: "NIC",
                          icon: Icons.branding_watermark,
                          validator: (value) =>NICFieldValidator.validate(value),
                          onChanged: (value) {
                            setState(() {
                              nic = value;
                            });
                          },
                        ),
                        RoundedInputField(
                          hintText: "Phone Number",
                          icon: Icons.phone,
                          validator: (value) => MobileFieldValidator.validate(value),
                          onChanged: (value) {
                            setState(() {
                              phoneNumber = value;
                            });
                          },
                        ),
                        RoundedInputField(
                          hintText: "Email",
                          validator: (value) =>EmailFieldValidator.validate(value),
                          onChanged: (value) {
                            setState(() {
                              email = value;
                            });
                          },
                        ),
                        RoundedPasswordField(
                          validator: (value) => PasswordFieldValidator.validate(value),
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                        ),
                        RoundedButton(
                            text: "SIGNUP",
                            press: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                dynamic result = await _authService
                                    .createUserWithEmailAndPassword(
                                        email,
                                        password,
                                        firstName,
                                        lastName,
                                        birthDay,
                                        nic,
                                        phoneNumber);
                                if (result == null) {
                                  setState(() {
                                    error = 'Please supply a valid email';
                                    loading = false;
                                  });
                                } else {
                                  Navigator.of(context).pop();
                                }
                              }
                            }),
                        SizedBox(height: 12.0),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 14.0),
                        )
                      ],
                    ),
                  ),
                  AlreadyHaveAnAccountCheck(
                    login: false,
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return LoginScreen();
                          },
                        ),
                      );
                    },
                  ),
                  /*OrDivider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SocalIcon(
                        iconSrc: "assets/icons/facebook.svg",
                        press: () {},
                      ),
                      SocalIcon(
                        iconSrc: "assets/icons/twitter.svg",
                        press: () {},
                      ),
                      SocalIcon(
                        iconSrc: "assets/icons/google-plus.svg",
                        press: () {},
                      ),
                    ],
                  )*/
                ],
              ),
            ),
          );
  }
}
