import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
//import 'package:flutter_dialogflow/flutter_dialogflow.dart

//import 'package:flutter_dialogflow_v2/flutter_dialogflow_v2.dart';
import 'package:intl/intl.dart';
import 'package:social_chat_bot_assistant/constants.dart';
import 'package:social_chat_bot_assistant/models/user_model.dart';
import 'package:social_chat_bot_assistant/services/database.dart';

class Complaint extends StatefulWidget {
  Complaint({Key key, this.title}) : super(key: key);

// This widget is the home page of your application. It is stateful, meaning
// that it has a State object (defined below) that contains fields that affect
// how it looks.

// This class is the configuration for the state. It holds the values (in this
// case the title) provided by the parent (in this case the App widget) and
// used by the build method of the State. Fields in a Widget subclass are
// always marked "final".

  final String title;

  @override
  _ComplaintState createState() => _ComplaintState();
}

class _ComplaintState extends State<Complaint> {
  // List userProfilesList = [];
  // String userID = "";
  // String uid;
  // String lastName;
  int account_num = null;
  String complain_type = null;
  String complain = null;
  int phone_number = null;
  String status = 'pending';
  String description = 'Complaint is received';
  DateTime createdAt = DateTime.now();

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
      print(i);

      setState(() {
        messsages.insert(0, {
          "data": 0,
          "message":
              aiResponse.getListMessage()[i]["text"]["text"][0].toString()
        });
      });
    }
  }

//--------------------
  void response(query) async {
    final user = await FirebaseAuth.instance.currentUser();
    final userData = await Firestore.instance
        .collection('clients')
        .document((user.uid))
        .get();
    final userName = userData['last_name'];
    // final phone_number = userData['phone_number'];
    CollectionReference complaintCollection =
        await Firestore.instance.collection('electricity_complaint');

    //-----------------------------------------------------------------------------------------------------
    AuthGoogle authGoogle = await AuthGoogle(
            fileJson: "assets/electricity-other-complai-tsdh-3a6737d1a7a7.json")
        .build();
    Dialogflow dialogflow =
        Dialogflow(authGoogle: authGoogle, language: Language.english);
    AIResponse aiResponse = await dialogflow.detectIntent(query);
//---------------------------------------

//-----------------------------------------
    // final List<Context> outputContexts = aiResponse.queryResult.outputContexts;
    //print(aiResponse.queryResult.);

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
        print(i);

        setState(() {
          messsages.insert(0, {
            "data": 0,
            "message":
                aiResponse.getListMessage()[i]["text"]["text"][0].toString()
          });
        });
      }
    } else if (aiResponse.queryResult.intent.displayName == 'ask-account-num') {
      insertMessage(aiResponse);
      account_num =
          int.parse(aiResponse.queryResult.parameters['account_number']);
    } else if (aiResponse.queryResult.intent.displayName ==
            'ask-breakdown-complain' ||
        aiResponse.queryResult.intent.displayName ==
            'ask-servicerequest-complain') {
      insertMessage(aiResponse);
      complain_type = aiResponse.queryResult.parameters['complain_type'];
    } else if (aiResponse.queryResult.intent.displayName ==
            'get-breakdown-complain' ||
        aiResponse.queryResult.intent.displayName ==
            'get-servicerequest-complain' ||
        aiResponse.queryResult.intent.displayName ==
            'get-other-servicerequest' ||
        aiResponse.queryResult.intent.displayName == 'get-breakdown-other') {
      insertMessage(aiResponse);
      complain =  aiResponse.queryResult.parameters['complains'];
      print(complain);
    }
    else if (aiResponse.queryResult.intent.displayName ==
            'get-other-servicerequest' ||
        aiResponse.queryResult.intent.displayName == 'get-breakdown-other') {
      insertMessage(aiResponse);
      complain ='other-'+  aiResponse.queryResult.parameters['complains'];
      print(complain);
    } else if (aiResponse.queryResult.intent.displayName ==
            'get-servicerequest-complain - yes' ||
        aiResponse.queryResult.intent.displayName ==
            'get-breakdown-complain - yes') {
      String reference;
      // reference_no = DateTime.now().millisecondsSinceEpoch;
      DocumentReference complainQuery =
          await Firestore.instance.collection('electricity_complaint').add({
        'account_number': account_num,
        'complain_type': complain_type,
        'complaint': complain,
        'user': user.uid,
        'status': status,
        'description': description,
        'createdAt': DateTime.now()
      });
      reference = complainQuery.documentID;
      //.then((value) => {reference = value.documentID, print(reference)})
      // ignore: invalid_return_type_for_catch_error
      //.catchError((error) => print(error));

      String mess =
          'Thank you! your complain is taken. Your reference id is $reference';
      setState(() {
        messsages.insert(0, {"data": 0, "message": mess});
      });
    } else {
      insertMessage(aiResponse);
      //  botSuggestions(aiResponse.getListMessage());
    }
  }

  final messageInsert = TextEditingController();
  List<Map> messsages = List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Complain bot",
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
                leading: IconButton(
                  icon: Icon(
                    Icons.camera_alt,
                    color: Colors.greenAccent,
                    size: 35,
                  ),
                ),
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
