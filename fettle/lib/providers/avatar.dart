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

  String name;
  double height;
  double weight;
  Gender gender = Gender.Male;

  HealthFactory health = HealthFactory();

  List<HealthDataType> types = [
    HealthDataType.BODY_MASS_INDEX,
    HealthDataType.ACTIVE_ENERGY_BURNED,
    HealthDataType.DISTANCE_WALKING_RUNNING,
    HealthDataType.WEIGHT,
    HealthDataType.HEIGHT,
    HealthDataType.SLEEP_IN_BED,
  ];

  List<HealthDataPoint> healthData = [];

  DateTime startDate = DateTime.utc(2001, 01, 01);
  DateTime endDate = DateTime.now();

  get heightString => height.toString() + 'm';
  get weightString => weight.round().toString() + 'kg';

  void update(AuthProvider auth) => this.auth = auth;

  Future fetchBioData() async {
    DocumentSnapshot avatarDocument = await FirebaseFirestore.instance
        .collection('avatars')
        .doc(auth.userId)
        .get();
    if (avatarDocument.data() == null) {
      onboarded = false;
    } else {
      name = avatarDocument.data()['name'];
      healthData =
          await health.getHealthDataFromTypes(startDate, endDate, types);
      healthData = HealthFactory.removeDuplicates(healthData);
      height = healthData
              .firstWhere((element) => element.type == HealthDataType.HEIGHT,
                  orElse: null)
              ?.value
              ?.toDouble() ??
          1.6;
      weight = healthData
              .lastWhere((element) => element.type == HealthDataType.WEIGHT,
                  orElse: null)
              ?.value
              ?.toDouble() ??
          50.0;
      gender = (avatarDocument.data()['gender'] == 'M')
          ? Gender.Male
          : Gender.Female;
      if (avatarDocument.data()['height'] != height ||
          avatarDocument.data()['weight'] != weight)
        FirebaseFirestore.instance.collection('avatars').doc(auth.userId).set({
          'height': height,
          'weight': weight,
        }, SetOptions(merge: true));
      onboarded = true;
    }
    print('return');
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
