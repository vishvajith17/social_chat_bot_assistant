import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:intl/intl.dart';
import 'package:social_chat_bot_assistant/constants.dart';
import 'package:social_chat_bot_assistant/models/user_model.dart';
import 'package:social_chat_bot_assistant/services/database.dart';

class BotChat extends StatefulWidget {
  BotChat({Key key, this.title}) : super(key: key);

// This widget is the home page of your application. It is stateful, meaning
// that it has a State object (defined below) that contains fields that affect
// how it looks.

// This class is the configuration for the state. It holds the values (in this
// case the title) provided by the parent (in this case the App widget) and
// used by the build method of the State. Fields in a Widget subclass are
// always marked "final".

  final String title;

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<BotChat> {
  //inquiry data
  String travel_medium = null;
  String travel_route_origin = null;
  String travel_route_destination = null;
  List lost_items = [];
  String lost_item_details = null;
  String lost_date = null;
  String get_off_time = null;
  String get_off_place = null;
  String vehicle_details = null;
  String status = "pending";
  String description = null;

  //review data
  int rate = null;
  String review = null;

  //client data
  String client_email = null;
  int client_phone_number = null;
  String client_NIC = null;
  int reference_no = null;

  void response(query) async {
    final user = await FirebaseAuth.instance.currentUser();
    final userData = await Firestore.instance
        .collection('clients')
        .document((user.uid))
        .get();
    final userName = userData['last_name'];
    final client_phone_number = userData['phone_number'];
    final client_NIC = userData['nic'];
    final client_email = userData['email'];

    final lostLog = await Firestore.instance
        .collection('transportLost')
        .where('email', isEqualTo: client_email)
        .getDocuments();

    CollectionReference transportLostData =
        await Firestore.instance.collection('transportLost');
    print(userName);

//---------------------------------------------------------------
    AuthGoogle authGoogle = await AuthGoogle(
            fileJson: "assets/lost-something-plgg-678667f69a6c.json")
        .build();
    Dialogflow dialogflow =
        Dialogflow(authGoogle: authGoogle, language: Language.english);
    AIResponse aiResponse = await dialogflow.detectIntent(query);

    print(aiResponse.queryResult.parameters);
    print(DateTime.now().millisecondsSinceEpoch);

    if (aiResponse.queryResult.intent.displayName == 'Default Welcome Intent') {
      setState(() {
        messsages.insert(0, {
          "data": 0,
          "message": aiResponse
              .getListMessage()[0]["text"]["text"][0]
              .toString()
              .replaceAll('user', userName)
        });
      });

      setState(() {
        messsages.insert(0, {
          "data": 0,
          "message":
              aiResponse.getListMessage()[1]["text"]["text"][0].toString()
        });
      });

      print(aiResponse
          .getListMessage()[0]["text"]["text"][0]
          .toString()
          .replaceAll('user', userName));
    } else {
      for (var i = 0; i < aiResponse.getListMessage().length; i++) {
        print(i);
        setState(() {
          messsages.insert(0, {
            "data": 0,
            "message":
                aiResponse.getListMessage()[i]["text"]["text"][0].toString()
          });
        });
      }
      if (aiResponse.queryResult.intent.displayName == 'travel-medium') {
        travel_medium = aiResponse.queryResult.parameters['travel-medium'];
        print(travel_medium);
      }
      if (aiResponse.queryResult.intent.displayName == 'travel-route') {
        travel_route_origin =
            aiResponse.queryResult.parameters['geo-city_origin'];
        travel_route_destination =
            aiResponse.queryResult.parameters['geo-city_destination'];
      }
      if (aiResponse.queryResult.intent.displayName == 'lost-items') {
        lost_items = aiResponse.queryResult.parameters['lost-items'];
      }
      if (aiResponse.queryResult.intent.displayName ==
          'lost-items - describe') {
        lost_item_details =
            aiResponse.queryResult.parameters['lost_item_details'];
      }
      if (aiResponse.queryResult.intent.displayName == 'travel-date') {
        lost_date = aiResponse.queryResult.parameters['date'];
      }
      if (aiResponse.queryResult.intent.displayName == 'travel-time') {
        get_off_time = aiResponse.queryResult.parameters['time'];
      }
      if (aiResponse.queryResult.intent.displayName == 'travel-getoff-place') {
        get_off_place = aiResponse.queryResult.parameters['geo-city_getoff'];
      }
      if (aiResponse.queryResult.intent.displayName ==
          'travel-vehicle_details') {
        vehicle_details = aiResponse.queryResult.parameters['vehicle_details'];
      }
      if (aiResponse.queryResult.intent.displayName == 'log') {
        if (lostLog.documents.isEmpty) {
          setState(() {
            messsages.insert(
                0, {"data": 0, "message": 'you dont have inquiry log history'});
          });
        } else {
          lostLog.documents.forEach((document) {
            reference_no = document['reference_no'];
            lost_date = document['lost_date'];
            lost_items = document['lost_items'];
            status = document['status'];
            if (document['description'] == null) {
              description = "not provided";
            } else {
              description = document['description'];
            }

            setState(() {
              messsages.insert(0, {
                "data": 0,
                "message": 'reference no:$reference_no  lost items:$lost_items '
                    'date:$lost_date             '
                    'status:$status                                          '
                    'description:$description'
              });
            });
          });
        }
        setState(() {
          messsages.insert(0, {
            "data": 0,
            "message":
                'If you want to log a inquiry about lost item type "Lost", to exit chat type "Exit" '
          });
        });
      }
      if (aiResponse.queryResult.intent.displayName == 'confirm - yes') {
        reference_no = DateTime.now().millisecondsSinceEpoch;
        if (travel_medium != null &&
            travel_route_origin != null &&
            travel_route_destination != null &&
            lost_items != null &&
            lost_date != null &&
            lost_date != null &&
            reference_no != null) {
          transportLostData
              .add({
                'medium': travel_medium,
                'route_origin': travel_route_origin,
                'route_destination': travel_route_destination,
                'lost_items': lost_items,
                'lost_item_details': lost_item_details,
                'lost_date': lost_date,
                'get_off_time': get_off_time,
                'get_off_place': get_off_place,
                'vehicle_details': vehicle_details,
                'reference_no': reference_no,
                'last_name': userName,
                'email': client_email,
                'phone_number': client_phone_number,
                'nic': client_NIC,
                'status': status
              })
              .then((value) => print('User Added'))
              .catchError((error) => print('failed to add user: $error'));
        }

        for (var i = 0; i < aiResponse.getListMessage().length; i++) {
          print(i);
          if (i == 0) {
            setState(() {
              messsages.insert(0, {
                "data": 0,
                "message": aiResponse
                    .getListMessage()[0]["text"]["text"][0]
                    .toString()
                    .replaceAll('ref.no', ': $reference_no')
              });
            });
          } else {
            setState(() {
              messsages.insert(0, {
                "data": 0,
                "message":
                    aiResponse.getListMessage()[1]["text"]["text"][0].toString()
              });
            });
          }
        }
      }

      print(aiResponse.getListMessage().length);
      print(aiResponse.getListMessage()[1]["text"]["text"][0].toString());
    }
  }

  final messageInsert = TextEditingController();
  List<Map> messsages = List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Lost Something?",
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 15, bottom: 10),
              child: Text(
                "Today, ${DateFormat("Hm").format(DateTime.now())}",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Flexible(
                child: ListView.builder(
                    reverse: true,
                    itemCount: messsages.length,
                    itemBuilder: (context, index) => chat(
                        messsages[index]["message"].toString(),
                        messsages[index]["data"]))),
            SizedBox(
              height: 20,
            ),
            Divider(
              height: 5.0,
              color: kPrimaryColor,
            ),
            Container(
              child: ListTile(
                title: Container(
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Color.fromRGBO(220, 220, 220, 1),
                  ),
                  padding: EdgeInsets.only(left: 15),
                  child: TextFormField(
                    controller: messageInsert,
                    decoration: InputDecoration(
                      hintText: "Enter a Message...",
                      hintStyle: TextStyle(color: Colors.black26),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    onChanged: (value) {},
                  ),
                ),
                trailing: IconButton(
                    icon: Icon(
                      Icons.send,
                      size: 30.0,
                      color: kPrimaryColor,
                    ),
                    onPressed: () {
                      if (messageInsert.text.isEmpty) {
                        print("empty message");
                      } else {
                        setState(() {
                          messsages.insert(
                              0, {"data": 1, "message": messageInsert.text});
                        });
                        response(messageInsert.text);
                        messageInsert.clear();
                      }
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                    }),
              ),
            ),
            SizedBox(
              height: 15.0,
            )
          ],
        ),
      ),
    );
  }

  //for better one i have use the bubble package check out the pubspec.yaml

  Widget chat(String message, int data) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment:
            data == 1 ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          data == 0
              ? Container(
                  height: 60,
                  width: 60,
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/icons/bot_avatar.png"),
                  ),
                )
              : Container(),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Bubble(
                radius: Radius.circular(15.0),
                color: data == 0 ? Colors.pinkAccent : Colors.purple,
                elevation: 0.0,
                child: Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        width: 10.0,
                      ),
                      Flexible(
                          child: Container(
                        constraints: BoxConstraints(maxWidth: 200),
                        child: Text(
                          message,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ))
                    ],
                  ),
                )),
          ),
          data == 1
              ? Container(
                  height: 60,
                  width: 60,
                  child: CircleAvatar(
                    backgroundColor: kPrimaryColor,
                    backgroundImage: AssetImage("assets/icons/user_avatar.png"),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
