import 'package:flutter/material.dart';
import 'package:social_chat_bot_assistant/screens/Help/components/background.dart';

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
                leading: Icon(Icons.help_center_rounded),
                title: Text("PUBLIC TRANSPORT"),
                subtitle: Text(
                    "complaint section : use Complaint keyword to lodge a complaint"),
              ),
            ])),
            Card(
                child:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              const ListTile(
                leading: Icon(Icons.help_center_rounded),
                title: Text("PUBLIC TRANSPORT"),
                subtitle: Text(
                    "lost something section : use Lost keyword to inform lost details"),
              ),
            ])),
            Card(
                child:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              const ListTile(
                leading: Icon(Icons.help_center_rounded),
                title: Text("PUBLIC TRANSPORT"),
                subtitle: Text(
                    "schedule section : use Schedule keyword to get details about schedule"),
              ),
            ])),
            Card(
                child:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              const ListTile(
                leading: Icon(Icons.help_center_rounded),
                title: Text("PUBLIC TRANSPORT"),
                subtitle: Text(
                    "complaint/lost something section : use Log keyword to check your previous inquiries"),
              ),
            ])),
            Card(
                child:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              const ListTile(
                leading: Icon(Icons.help_center_rounded),
                title: Text("PUBLIC TRANSPORT"),
                subtitle: Text("all sections : use Exit keyword to end chat"),
              ),
            ])),
            SizedBox(height: size.height * 0.03),
            Card(
                child:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              const ListTile(
                leading: Icon(Icons.help_center_rounded),
                title: Text("ELECTRICITY"),
                subtitle: Text(
                    "complaint section : use Complaint keyword to lodge a complaint"),
              ),
            ])),
            Card(
                child:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              const ListTile(
                leading: Icon(Icons.help_center_rounded),
                title: Text("ELECTRICITY"),
                subtitle: Text(
                    "schedule section : use Schedule keyword to get schedule"),
              ),
            ])),
            Card(
                child:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              const ListTile(
                leading: Icon(Icons.help_center_rounded),
                title: Text("ELECTRICITY"),
                subtitle: Text(
                    "sudden power-cut section : use power-cut keyword to log a complaint in electricity"),
              ),
            ])),
            SizedBox(height: size.height * 0.03),
            Card(
                child:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              const ListTile(
                leading: Icon(Icons.help_center_rounded),
                title: Text("TELECOMMUNICATION"),
                subtitle: Text(
                    "complaint section : use Complaint keyword to log a complaint in telecommunication"),
              ),
            ])),
            Card(
                child:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              const ListTile(
                leading: Icon(Icons.help_center_rounded),
                title: Text("TELECOMMUNICATION"),
                subtitle: Text(
                    "subscription section : use Subscription keyword to check subscription details"),
              ),
            ])),
            Card(
                child:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              const ListTile(
                leading: Icon(Icons.help_center_rounded),
                title: Text("TELECOMMUNICATION"),
                subtitle: Text(
                    "balance section : use Balance keyword to check your balance"),
              ),
            ])),
            SizedBox(height: size.height * 0.03),
          ],
        ),
      ),
    );
  }
}
