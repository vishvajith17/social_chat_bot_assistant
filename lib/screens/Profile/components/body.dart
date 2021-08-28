import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_chat_bot_assistant/components/loading.dart';
import 'package:social_chat_bot_assistant/models/user_model.dart';
import 'package:social_chat_bot_assistant/screens/Profile/components/background.dart';
import 'package:social_chat_bot_assistant/services/database.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();

  // form values
  String _currentFirstName;
  String _currentLastName;
  String _currentEmail;
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
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Text(
                      'PROFILE',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      initialValue: userData.first_name,
                      decoration: InputDecoration(),
                      validator: (val) =>
                          val.isEmpty ? 'Please enter a name' : null,
                      onChanged: (val) =>
                          setState(() => _currentFirstName = val),
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      initialValue: userData.last_name,
                      decoration: InputDecoration(),
                      validator: (val) =>
                          val.isEmpty ? 'Please enter a name' : null,
                      onChanged: (val) =>
                          setState(() => _currentLastName = val),
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      initialValue: userData.birthday,
                      decoration: InputDecoration(),
                      validator: (val) =>
                          val.isEmpty ? 'Please enter a name' : null,
                      onChanged: (val) =>
                          setState(() => _currentBirthDate = val),
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      initialValue: userData.nic,
                      decoration: InputDecoration(),
                      validator: (val) =>
                          val.isEmpty ? 'Please enter a name' : null,
                      onChanged: (val) => setState(() => _currentNIC = val),
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      initialValue: userData.phonenumber,
                      decoration: InputDecoration(),
                      validator: (val) =>
                          val.isEmpty ? 'Please enter a name' : null,
                      onChanged: (val) =>
                          setState(() => _currentPhoneNumber = val),
                    ),
                    RaisedButton(
                        color: Colors.pink[400],
                        child: Text(
                          'Update',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            await DatabaseService(uid: user.uid).updateUserData(
                              _currentFirstName ?? snapshot.data.first_name,
                              _currentLastName ?? snapshot.data.last_name,
                              _currentBirthDate ?? snapshot.data.birthday,
                              _currentNIC ?? snapshot.data.nic,
                              _currentPhoneNumber ?? snapshot.data.phonenumber,
                            );
                            Navigator.pop(context);
                          }
                        }),
                  ],
                ),
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
