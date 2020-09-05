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
import 'package:health/health.dart';

class AvatarProvider with ChangeNotifier {
  AuthProvider auth;

  bool onboarded = false;
  bool autoSleep = false;

  String name;
  double height;
  double weight;
  Gender gender = Gender.Male;

  bool isSleeping = false;

  get heightString => height.toString() + 'm';
  get weightString => weight.round().toString() + 'kg';

  void update(AuthProvider auth) => this.auth = auth;

  Future fetchBioData() async {
    print("fetching bio data");
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
      gender = (avatarDocument.data()['gender'] == 'M')
          ? Gender.Male
          : Gender.Female;
      autoSleep = avatarDocument.data()['autoSleep'];
      isSleeping = avatarDocument.data()['isSleeping'];
      onboarded = true;
    }
    return;
  }

  void updateAutoSleep(bool auto) {
    print("updating auto sleep");
    autoSleep = auto;
    FirebaseFirestore.instance
        .collection('avatars')
        .doc(auth.userId)
        .set({'autoSleep': autoSleep}, SetOptions(merge: true));
    notifyListeners();
  }

  void toggleSleepStatus() {
    print("toggling sleep status");
    isSleeping = !isSleeping;
    FirebaseFirestore.instance
        .collection('avatars')
        .doc(auth.userId)
        .set({'isSleeping': isSleeping}, SetOptions(merge: true));
    notifyListeners();
  }

  Future saveBioData(
      String name, double height, double weight, Gender gender) async {
    print("saving bio data");
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
      'gender': (gender == Gender.Male) ? 'M' : 'F',
      'autoSleep': autoSleep,
      'isSleeping': isSleeping
    }, SetOptions(merge: true));
    onboarded = true;
    notifyListeners();
    return;
  }
}
