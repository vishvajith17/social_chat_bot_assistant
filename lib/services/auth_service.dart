import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_chat_bot_assistant/models/user_model.dart';
import 'package:social_chat_bot_assistant/services/database.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User _userFromFirebase(FirebaseUser user) {
    if (user == null) {
      return null;
    }
    return User(uid: user.uid, email: user.email);
  }

  Stream<User> get user {
    return _firebaseAuth.onAuthStateChanged.map(_userFromFirebase);
  }

  Future signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      AuthResult credential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      print("**" + email + password);
      FirebaseUser user = credential.user;

      return _userFromFirebase(user);
    } catch (error) {
      print("test" + error.toString());
      return null;
    }
  }

  Future createUserWithEmailAndPassword(
    String email,
    String password,
    String fname,
    String lname,
    String bday,
    String nic,
    String phone_number,
  ) async {
    try {
      AuthResult credential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = credential.user;
      await DatabaseService(uid: user.uid).registerUserData(
          user.uid, user.email, fname, lname, bday, nic, phone_number);
      return _userFromFirebase(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _firebaseAuth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
