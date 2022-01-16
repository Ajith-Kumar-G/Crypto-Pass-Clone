import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Instance {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool verifiedEmail() {
    User? user = _auth.currentUser;

    if (user != null && !user.emailVerified) user.sendEmailVerification();

    if (user != null && user.emailVerified)
      return true;
    else
      return false;
  }
}
