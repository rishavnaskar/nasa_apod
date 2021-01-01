import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleLogin {
  final GoogleSignIn _googlSignIn = GoogleSignIn(scopes: <String>['email']);
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void googleLoginUser(BuildContext context) async {
    try {
      final GoogleSignInAccount googleSignInAccount =
          await _googlSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleSignInAccount.authentication;
      // ignore: deprecated_member_use
      final AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
      await _firebaseAuth.signInWithCredential(credential);
    } catch (error) {
      print(error);
    }
  }

  void googleLogoutUser(BuildContext context) {
    _googlSignIn.signOut();
    _firebaseAuth.signOut();
  }
}
