import 'package:flutter/material.dart';
import 'package:social_chat_bot_assistant/screens/AboutUs/components/background.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
                child:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              const ListTile(
                leading: Icon(Icons.important_devices),
                title: Text("SOCIAL INQUIRY CHAT-BOT MOBILE APPLICATION"),
                subtitle: Text("CSE GROUP 38 - PID 20"),
              ),
            ])),
            Card(
                child:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              const ListTile(
                leading: Icon(Icons.info),
                title: Text("DEVELOPERS"),
              ),
            ])),
            Card(
                child:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              const ListTile(
                leading: Icon(Icons.star),
                title: Text("H.G.M.VISHVAJITH"),
                subtitle: Text("maduka.18@cse.mrt.ac.lk"),
              ),
            ])),
            Card(
                child:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              const ListTile(
                leading: Icon(Icons.star),
                title: Text("V.SALINY"),
                subtitle: Text("sakiny.18@cse.mrt.ac.lk"),
              ),
            ])),
            Card(
                child:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              const ListTile(
                leading: Icon(Icons.star),
                title: Text("V.VIPOOSHAN"),
                subtitle: Text("vipooshan.18@cse.mrt.ac.lk"),
              ),
            ])),
            Card(
                child:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              const ListTile(
                leading: Icon(Icons.info),
                title: Text("MENTOR"),
                subtitle: Text("DR.NISANSA DE SILVA"),
              ),
            ])),
            SizedBox(height: size.height * 0.03),
          ],
        ),
      ),
    );
  }
}
