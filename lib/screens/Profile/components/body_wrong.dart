import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_chat_bot_assistant/models/user_model.dart';
import 'package:social_chat_bot_assistant/screens/Profile/components/background.dart';
import 'package:social_chat_bot_assistant/screens/Profile/components/profile_data_list.dart';
import 'package:social_chat_bot_assistant/services/database.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*Size size = MediaQuery.of(context).size;*/
    /*return Background(
      child: StreamProvider<List<User>>.value(
          value: DatabaseService().clients,
          child: Scaffold(
            body: ProfileDataList(),
          )),
    );*/

    /*child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.red,
            backgroundImage: NetworkImage(
                'https://images.pexels.com/photos/1987301/pexels-photo-1987301.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
          ),
          Text(
            'Maduka Vishvajith',
            style: TextStyle(
              fontFamily: 'Pacifio',
              fontSize: 40.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
            width: 150,
            child: Divider(
              color: Colors.teal.shade100,
            ),
          ),
          Card(
            color: Colors.white,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            child: ListTile(
              leading: Icon(
                Icons.phone,
                color: Colors.teal,
              ),
              title: Text(
                '+94 77 4722 315',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.teal.shade900,
                  fontFamily: 'Source Sans Pro',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Card(
            color: Colors.white,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            child: ListTile(
              leading: Icon(
                Icons.email,
                color: Colors.teal,
              ),
              title: Text(
                'maduka.18@cse.mrt.ac.lk',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.teal.shade900,
                  fontFamily: 'Source Sans Pro',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ]),*/
  }
}
