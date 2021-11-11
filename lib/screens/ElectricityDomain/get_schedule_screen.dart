import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:intl/intl.dart';
import 'package:social_chat_bot_assistant/constants.dart';

class GetSchedule extends StatefulWidget {
  GetSchedule({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _GetScheduleState createState() => _GetScheduleState();
}

class _GetScheduleState extends State<GetSchedule> {
// for suggestions
  List<String> suggestions = [];
  void botSuggestions(List<dynamic> responses) {
    //responses = aiResponse.getListMessage()

    responses.forEach((message) {
      if (message['payload'] != null) {
        List<dynamic> suggestionList = message['payload']['suggestions'];
        suggestionList.forEach((suggestion) => {
              setState(() {
                messsages.insert(0, {
                  "data": 0,
                  "message": message["text"]["text"][0].toString()
                });
              })
            });
      }
    });
  } //----------

  // multiple response
  void insertMessage(AIResponse aiResponse) {
    for (var i = 0; i < aiResponse.getListMessage().length; i++) {
      setState(() {
        messsages.insert(0, {
          "data": 0,
          "message":
              aiResponse.getListMessage()[i]["text"]["text"][0].toString()
        });
      });
    }
  }

  //------------get schedule from db
  void getSchedule(String acc_num, String date) async {
    String area;
    String timeFrom;
    String timeTo;
    String msg;
    String checkMess =
        'Checking for schedule...\nAccount number: $acc_num \nDate: $date';
    setState(() {
      messsages.insert(0, {"data": 0, "message": checkMess});
    });

    final e_userCollection = await Firestore.instance
        .collection('e_users')
        .where("registration", isEqualTo: acc_num)
        .getDocuments();
    e_userCollection.documents.forEach((document) {
      area = document['area'];
    });

    final scheduleCollection = await Firestore.instance
        .collection('e_schedules')
        .where("date", isEqualTo: date)
        .where("areas", arrayContains: area)
        .getDocuments();
    if (scheduleCollection.documents.isEmpty) {
      msg = 'There are no powercut schedule for $acc_num on $date. Thank you';
    } else {
      scheduleCollection.documents.forEach((document) {
        timeFrom = document['timeFrom'];
        timeTo = document['timeTo'];
        msg = 'There is a power scheduled from $timeFrom to $timeTo. Thank you';
      });
    }
    setState(() {
      messsages.insert(0, {"data": 0, "message": msg});
    });
  }

//---------------
  void response(query) async {
    String account_num;
    String scdate;
    String formatedsdate;

    final user = await FirebaseAuth.instance.currentUser();
    final userData = await Firestore.instance
        .collection('clients')
        .document((user.uid))
        .get();
    final userName = userData['last_name'];

    //-----------------------------------------------------------------------------------------------------
    AuthGoogle authGoogle = await AuthGoogle(
            fileJson: "assets/electricity-power-schedul-tsbv-701136c4a6d8.json")
        .build();
    Dialogflow dialogflow =
        Dialogflow(authGoogle: authGoogle, language: Language.english);
    AIResponse aiResponse = await dialogflow.detectIntent(query);
//---------------------------------------

//-----------------------------------------
    // final List<Context> outputContexts = aiResponse.queryResult.outputContexts;

    if (aiResponse.queryResult.intent.displayName == 'Welcome.default') {
      setState(() {
        messsages.insert(0, {
          "data": 0,
          "message": aiResponse
              .getListMessage()[0]["text"]["text"][0]
              .toString()
              .replaceAll('user', userName)
        });
      });
      for (var i = 1; i < aiResponse.getListMessage().length; i++) {
        setState(() {
          messsages.insert(0, {
            "data": 0,
            "message":
                aiResponse.getListMessage()[i]["text"]["text"][0].toString()
          });
        });
      }
    } else if (aiResponse.queryResult.intent.displayName == 'get-all') {
      account_num = aiResponse.queryResult.parameters['account_number'];
      var strdate;
      strdate = aiResponse.queryResult.parameters["date"];
      formatedsdate = strdate.split(
            'T')[0]; //yesterday........2021-09-24T12:00:00+05:30...string

      if (account_num != '' && formatedsdate != '') {        
        getSchedule(account_num, formatedsdate);
      } else {
        insertMessage(aiResponse);
      }
    } else if (aiResponse.queryResult.intent.displayName == 'ask-account-num') {
      insertMessage(aiResponse);
      account_num = aiResponse.queryResult.parameters['account_number'];
    } else if (aiResponse.queryResult.intent.displayName == 'ask-date-time') {
      insertMessage(aiResponse);
      var strdate;
      strdate = aiResponse.queryResult.parameters["date"];
      formatedsdate = strdate
          .split('T')[0]; //yesterday........2021-09-24T12:00:00+05:30...string

      // date = DateTime.parse(
      //     formatedsdate); //argument should be some format..2021-09-24T05:00:00
    } else if (aiResponse.queryResult.intent.displayName ==
        'ask-date-time - yes') {
      String area;
      String timeFrom;
      String timeTo;
      String msg;
      String date;
      String checkMess = 'Checking for schedule...';
      setState(() {
        messsages.insert(0, {"data": 0, "message": checkMess});
      });

      final e_userCollection = await Firestore.instance
          .collection('e_users')
          .where("registration", isEqualTo: account_num)
          .getDocuments();
      e_userCollection.documents.forEach((document) {
        area = document['area'];
      });

      final scheduleCollection = await Firestore.instance
          .collection('e_schedules')
          .where("date", isEqualTo: formatedsdate)
          .where("areas", arrayContains: area)
          .getDocuments();
      if (scheduleCollection.documents.isEmpty) {
        msg = 'There are no powercut schedule for you. Thank you';
      } else {
        scheduleCollection.documents.forEach((document) {
          timeFrom = document['timeFrom'];
          timeTo = document['timeTo'];
          msg =
              'There is a power scheduled from $timeFrom to $timeTo. Thank you';
        });
      }

      setState(() {
        messsages.insert(0, {"data": 0, "message": msg});
      });
    } else {
      insertMessage(aiResponse);
    }
  }

  final messageInsert = TextEditingController();
  List<Map> messsages = List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "PowerCut-schedule bot",
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
              color: Colors.greenAccent,
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
                      color: Colors.greenAccent,
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
                color: data == 0
                    ? Color.fromRGBO(23, 157, 139, 1)
                    : Colors.orangeAccent,
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
