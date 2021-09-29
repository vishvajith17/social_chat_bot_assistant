import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_chat_bot_assistant/models/user_model.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // final CollectionReference profileList =
  // Firestore.instance.collection('clients');

  // collection reference
  final CollectionReference chatbotCollection =
      Firestore.instance.collection('clients');

  //register user in firestore
  Future<void> registerUserData(String uid, String email, String fname,
      String lname, String bday, String nic, String phonenumber) async {
    return await chatbotCollection.document(uid).setData({
      'user_id': uid,
      'email': email,
      'first_name': fname,
      'last_name': lname,
      'birth_day': bday,
      'nic': nic,
      'phone_number': phonenumber,
    });
  }

  //update user data
  Future updateUserData(String uid, String email, String fname, String lname,
      String bday, String nic, String phonenumber) async {
    return await chatbotCollection.document(uid).setData({
      'user_id': uid,
      'email': email,
      'first_name': fname,
      'last_name': lname,
      'birth_day': bday,
      'nic': nic,
      'phone_number': phonenumber,
    });
  }

  //get user data from firestore
  User _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return User(
      uid: uid,
      first_name: snapshot.data['first_name'],
      last_name: snapshot.data['last_name'],
      email: snapshot.data['email'],
      birthday: snapshot.data['birth_day'],
      nic: snapshot.data['nic'],
      phonenumber: snapshot.data['phone_number'],
    );
  }

  // //get user data from firebase
  // Future getUsersList() async {
  //   List itemsList = [];
  //
  //   try {
  //     await profileList.getDocuments().then((querySnapshot) {
  //       querySnapshot.documents.forEach((element) {
  //         itemsList.add(element.data);
  //       });
  //     });
  //     return itemsList;
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  // get user doc stream
  Stream<User> get userData {
    return chatbotCollection
        .document(uid)
        .snapshots()
        .map(_userDataFromSnapshot);
  }
}
