import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../providers/auth.dart';
import '../constants.dart';

class AvatarProvider with ChangeNotifier {
  AuthProvider auth;
  bool onboarded = false;

  String name;
  double height;
  double weight;
  Gender gender;

  get heightString => height.round().toString() + 'cm';
  get weightString => weight.round().toString() + 'kg';

  void update(AuthProvider auth) {
    this.auth = auth;
  }

  Future fetchBioData() async {
    DocumentSnapshot avatarDocument = await FirebaseFirestore.instance
        .collection('avatars')
        .doc(auth.userId)
        .get();
    if (avatarDocument.data() == null) {
      onboarded = false;
    } else {
      name = avatarDocument.data()['name'];
      height = avatarDocument.data()['height'];
      weight = avatarDocument.data()['weight'];
      gender =
          avatarDocument.data()['gender'] == 'M' ? Gender.Male : Gender.Female;
      onboarded = true;
    }
    return;
  }

  Future saveBioData(
      String name, double height, double weight, Gender gender) async {
    this.height = height;
    this.weight = weight;
    this.gender = gender;
    this.name = name;
    await FirebaseFirestore.instance
        .collection('avatars')
        .doc(auth.userId)
        .set({
      'name': name,
      'height': height,
      'weight': weight,
      'gender': (gender == Gender.Male) ? 'M' : 'F'
    }, SetOptions(merge: true));
    onboarded = true;
    notifyListeners();
    return;
  }
}
