import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> signInWithEmail(String email, String password) async {
    User? user = FirebaseAuth.instance.currentUser;

    // if (user != null && !user.emailVerified) {
    //   await user.sendEmailVerification();
    // }
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      if (user != null)
        return true;
      else
        return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> addUser(emailE, passwordE) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: emailE, password: passwordE);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> logOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("error logging out");
    }
    GoogleSignIn().signOut();
  }

  Future<bool> loginWithGoogle() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount? account = await googleSignIn.signIn();
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      await users
          .add({
            'Email': account?.email,
            'Phone': account?.displayName,
            'Password': account?.email,
            'UID': _auth.currentUser?.uid.toString(),
          })
          .then((value) => print("Site added"))
          .catchError((error) => print("Failed to add site: $error"));
      if (account == null) return false;
      UserCredential res =
          await _auth.signInWithCredential(GoogleAuthProvider.credential(
        idToken: (await account.authentication).idToken,
        accessToken: (await account.authentication).accessToken,
      ));

      if (res.user == null) return false;
      return true;
    } catch (e) {
      print(e);
      print("Error logging with google");
      return false;
    }
  }

  String? getMail() {
    final User? user = _auth.currentUser;
    String? mail = user?.email;

    if (mail != null) return mail.split('@')[0];
  }

  String? getUID() {
    final User? user = _auth.currentUser;
    String? uid = user?.uid;

    if (uid != null) return uid;
  }
}
