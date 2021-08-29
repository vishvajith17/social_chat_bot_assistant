import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_chat_bot_assistant/components/loading.dart';
import 'package:social_chat_bot_assistant/components/rounded_button.dart';
import 'package:social_chat_bot_assistant/components/rounded_input_field.dart';
import 'package:social_chat_bot_assistant/constants.dart';
import 'package:social_chat_bot_assistant/models/user_model.dart';
import 'package:social_chat_bot_assistant/screens/Profile/components/background.dart';
import 'package:social_chat_bot_assistant/services/database.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  //form key
  final _formKey = GlobalKey<FormState>();

  // form values
  String _currentFirstName;
  String _currentLastName;
  String _currentNIC;
  String _currentBirthDate;
  String _currentPhoneNumber;

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    return StreamBuilder<User>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            User userData = snapshot.data;
            return Background(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(
                          radius: 50,
                          backgroundColor: kPrimaryColor,
                          backgroundImage:
                              AssetImage('assets/icons/user_avatar.png')),
                      SizedBox(height: 10.0),
                      RoundedInputField(
                        initialValue: userData.first_name,
                        hintText: 'first name',
                        validator: (val) =>
                            val.isEmpty ? 'Please enter first name' : null,
                        onChanged: (val) =>
                            setState(() => _currentFirstName = val),
                      ),
                      RoundedInputField(
                        initialValue: userData.last_name,
                        hintText: 'last name',
                        validator: (val) =>
                            val.isEmpty || val == _currentFirstName
                                ? 'Please enter last name'
                                : null,
                        onChanged: (val) =>
                            setState(() => _currentLastName = val),
                      ),
                      RoundedInputField(
                        initialValue: userData.birthday,
                        hintText: 'birthday (YYYY/MM/DD)',
                        icon: Icons.cake,
                        validator: (val) =>
                            val.isEmpty ? 'Please enter birth day' : null,
                        onChanged: (val) =>
                            setState(() => _currentBirthDate = val),
                      ),
                      RoundedInputField(
                        initialValue: userData.nic,
                        hintText: 'NIC',
                        icon: Icons.branding_watermark,
                        validator: (val) => val.isEmpty
                            ? 'Please enter a valid NIC number'
                            : null,
                        onChanged: (val) => setState(() => _currentNIC = val),
                      ),
                      RoundedInputField(
                        initialValue: userData.phonenumber,
                        hintText: 'phone number',
                        icon: Icons.phone,
                        validator: (val) => val.length < 10 || val.length > 10
                            ? 'Please enter phone number'
                            : null,
                        onChanged: (val) =>
                            setState(() => _currentPhoneNumber = val),
                      ),
                      RoundedButton(
                        text: 'UPDATE',
                        press: () async {
                          if (_formKey.currentState.validate()) {
                            await DatabaseService(uid: user.uid).updateUserData(
                              snapshot.data.uid,
                              snapshot.data.email,
                              _currentFirstName ?? snapshot.data.first_name,
                              _currentLastName ?? snapshot.data.last_name,
                              _currentBirthDate ?? snapshot.data.birthday,
                              _currentNIC ?? snapshot.data.nic,
                              _currentPhoneNumber ?? snapshot.data.phonenumber,
                            );
                            Navigator.pop(context);
                          }
                        },
                      ),
                      /*TextFormField(
                        initialValue: userData.last_name,
                        decoration: InputDecoration(),
                        validator: (val) =>
                            val.isEmpty ? 'Please enter a name' : null,
                        onChanged: (val) =>
                            setState(() => _currentLastName = val),
                      ),*/
                      /*RaisedButton(
                          color: Colors.pink[400],
                          child: Text(
                            'Update',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              await DatabaseService(uid: user.uid)
                                  .updateUserData(
                                snapshot.data.uid,
                                snapshot.data.email,
                                _currentFirstName ?? snapshot.data.first_name,
                                _currentLastName ?? snapshot.data.last_name,
                                _currentBirthDate ?? snapshot.data.birthday,
                                _currentNIC ?? snapshot.data.nic,
                                _currentPhoneNumber ??
                                    snapshot.data.phonenumber,
                              );
                              Navigator.pop(context);
                            }
                          }),*/
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
