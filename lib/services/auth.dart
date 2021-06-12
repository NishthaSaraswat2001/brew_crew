import 'package:brew_crew/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
//methods that interect with firebase auth

//create FireBaseAuth object to access funtionality of fire base authentication (backend)
//It knows which backend to connect using google-services.json file present in android/app folder
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ModelUser _createCustomModelUser(User user) {
    return (user != null) ? ModelUser(uid: user.uid) : null;
  }

//stream for auth
  Stream<ModelUser> get user {
    return _auth
        .authStateChanges()
        .map((User user) => _createCustomModelUser(user));
  }

//sign in anony
  Future signInAnony() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _createCustomModelUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//sign in with email & password
  Future signInWithEmailAndPasswaord(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _createCustomModelUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//register with email
  Future registerWithEmailAndPasswaord(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _createCustomModelUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
