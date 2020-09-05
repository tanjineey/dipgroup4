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
  bool onboarded = false;

  bool get isLoggedIn => _fAuth.currentUser != null;
  String get userId => _fAuth.currentUser.uid;

  Future<bool> socialLogin() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount == null) return false;
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final UserCredential authResult =
          await _fAuth.signInWithCredential(credential);
      User user = authResult.user;
      firebaseMessaging.getToken().then((token) async {
        FirebaseFirestore.instance.collection('users').doc(user.uid).update({
          'pushToken': token,
        });
      }).catchError((err) {
        print(err);
      });
    } catch (e) {
      print(e);
    }
    notifyListeners();
    return true;
  }

  Future<bool> socialLogout() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    await _fAuth.signOut();
    notifyListeners();
    return true;
  }
}
