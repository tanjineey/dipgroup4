import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _fAuth = FirebaseAuth.instance;
  final FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
  bool initOnline = false;
  bool tempLockDisable = false;
  User user;

  bool get isLoggedIn => _fAuth.currentUser != null;

  Future<bool> socialLogin() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.disconnect();
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount == null) return false;
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final UserCredential authResult =
        await _fAuth.signInWithCredential(credential);
    final User user = authResult.user;
    firebaseMessaging.getToken().then((token) async {
      FirebaseFirestore.instance.collection('users').doc(user.uid).update({
        'pushToken': token,
      });
    }).catchError((err) {});
    notifyListeners();
    return true;
  }

  Future<bool> socialLogout() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    await _fAuth.signOut();
    user = null;
    notifyListeners();
    return true;
  }
}
